import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:http/http.dart' as http;

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 5:47 PM
 */
class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final String authToken;
  Orders(this.authToken);

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    print('fetch order');
    final url =
        'https://shop-app-bc0e1-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, value) {
        loadedOrders.add(OrderItem(
            id: orderId,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price']))
                .toList(),
            dateTime: DateTime.parse(value['dateTime'])));
        _orders = loadedOrders.reversed.toList();
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }

  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url =
        'https://shop-app-bc0e1-default-rtdb.firebaseio.com/orders.json';
    try {
      final timestamp = DateTime.now();
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price
                    })
                .toList()
          }));
      if (response.statusCode > 400) {
        throw HttpException('Add order failed');
      }
      _orders.insert(
          0,
          OrderItem(
              id: DateTime.now().toString(),
              amount: total,
              products: cartProducts,
              dateTime: DateTime.now()));
      notifyListeners();
    } catch (error) {
      throw HttpException('Add order failed');
    }
  }
}

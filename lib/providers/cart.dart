import 'package:flutter/cupertino.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 1:55 PM
 */

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (value) => CartItem(
              id: id,
              title: title,
              quantity: value.quantity + 1,
              price: price));
    } else {
      _items.putIfAbsent(
          id, () => CartItem(id: id, title: title, quantity: 1, price: price));
    }
    notifyListeners();
  }

  int itemCount() {
    return _items.length;
  }

  double totalAmount() {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
    notifyListeners();
  }
}

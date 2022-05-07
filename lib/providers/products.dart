import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 10:11 AM
 */

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  bool _showFavorites = false;

  List<Product> get items {
    if (_showFavorites) {
      return _items.where((element) => element.isFavorite == true).toList();
    }
    return [..._items];
  }

  Product finById(String productId) {
    return _items.firstWhere((element) => element.id == productId);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://shop-app-bc0e1-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractedData.forEach((key, value) {
        final _product = Product(
          id: key,
          title: value['title'],
          description: value['description'],
          imageUrl: value['imageUrl'],
          price: value['price']
        );
        loadedProduct.add(_product);
        _items = loadedProduct;
      });
      notifyListeners();
      print(json.decode(response.body));
    }
    catch(error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://shop-app-bc0e1-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "imageUrl": product.imageUrl
          }));
      product.id = json.decode(response.body)['name'];
      _items.add(product);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async{
    try {
      final idxProduct = _items.indexWhere((element) => element.id == id);
      print("update Product");
      print(idxProduct);
      if (idxProduct > -1) {
      final url = "https://shop-app-bc0e1-default-rtdb.firebaseio.com/products/$id.json";
      await http.patch(Uri.parse(url), body: json.encode({
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "imageUrl": product.imageUrl
      }));
        _items[idxProduct] = product;
      }
      notifyListeners();
    }
    catch(error) {
      throw error;
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void showFavoritesOnly() {
    _showFavorites = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorites = false;
    notifyListeners();
  }
}

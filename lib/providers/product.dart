import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String _id;
  String _title;
  String _description;
  double _price;
  String _imageUrl;
  bool _isFavorite;

  // Getter setter
  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
  }

  //Constructor
  Product({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    bool? isFavorite,
  })  : _id = id,
        _title = title,
        _description = description,
        _price = price,
        _imageUrl = imageUrl,
        _isFavorite = isFavorite ?? false;

  //Method
  void _setFavoriteStatus(bool status) {
    _isFavorite = status;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async{
    final url =
        "https://shop-app-bc0e1-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
    final _oldStatus = _isFavorite;
    _isFavorite = !_isFavorite;
    _setFavoriteStatus(_isFavorite);
    try {
      final response = await http.patch(Uri.parse(url), body: json.encode({
        'isFavorite': _isFavorite
      }));
      if(response.statusCode > 400) {
        _setFavoriteStatus(_oldStatus);
        throw HttpException('Update favorite status failed');
      }
    }
    catch(error) {
      _setFavoriteStatus(_oldStatus);
      throw error;
    }
  }
}

import 'package:flutter/foundation.dart';

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
  void toggleFavoriteStatus() {
    this._isFavorite = !this._isFavorite;
    notifyListeners();
  }
}

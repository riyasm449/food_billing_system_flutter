import 'package:flutter/material.dart';
import 'package:food_bill/models/product.dart';

class FoodProvider extends ChangeNotifier {
  List<Cart> _cart = [];
  List<Cart> get cart => _cart;
  int _total = 0;
  int get tatal => _total;

  bool isInCart(Product product) {
    bool found = false;
    for (int i = 0; i < _cart.length; i++) {
      if (product.name == _cart[i].product.name) {
        found = true;
        break;
      }
    }
    return found;
  }

  int indexInCart(Product product) {
    int found;
    for (int i = 0; i < _cart.length; i++) {
      if (product.name == _cart[i].product.name) {
        found = i;
        break;
      }
    }
    return found;
  }

  addCart(Product product) {
    if (isInCart(product)) {
      _cart[indexInCart(product)].qty += 1;
    } else {
      _cart.add(Cart(product, 1));
    }
    notifyListeners();
    getTotal();
  }

  removeCart(Product product) {
    if (isInCart(product)) {
      if (_cart[indexInCart(product)].qty == 1)
        _cart.removeAt(indexInCart(product));
      else
        _cart[indexInCart(product)].qty -= 1;
    }
    notifyListeners();
    getTotal();
  }

  getTotal() {
    int sum = 0;
    if (_cart.isNotEmpty) {
      for (int i = 0; i < _cart.length; i++) {
        sum += (_cart[i].product.price * _cart[i].qty);
      }
    }
    _total = sum;
    notifyListeners();
  }
}

class Cart {
  Product product;
  int qty;

  Cart(this.product, this.qty);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.product.name;
    data['price'] = this.product.price;
    data['image'] = this.product.image;
    data['qty'] = this.qty;
    return data;
  }
}

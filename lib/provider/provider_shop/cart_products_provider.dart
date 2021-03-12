import 'package:flutter/material.dart';
import 'package:flutter_demo/models/products/cart.dart';
import 'package:flutter_demo/models/products/product.dart';

class CartsProvider with ChangeNotifier {
  List<Cart> _cart = List();
  getCountListProducts() => _cart.length;
  getListProducts() => _cart;

  int _totalProductMoney = 0;
  getTotalProductMeney() => _totalProductMoney;
  int _amount = 0;
  getAmount() => _amount;
  int _totalMoneyInCart = 0;
  getTotalMoneyInCart() => _totalMoneyInCart;

  void getAmountAndTotalMoney(Product p) {
    for (var x in _cart) {
      if (x.product.id == p.id) {
        _amount = x.amount;
        _totalProductMoney = int.parse(p.price) * x.amount;
        notifyListeners();
        return;
      }
    }
    _amount = 0;
    _totalProductMoney = 0;
    notifyListeners();
  }

  // void increAmount(int price) {
  //   _amount++;
  //   _totalProductMoney = price * _amount;
  //   notifyListeners();
  // }

  // void decreAmount(int price) {
  //   if (_amount > 0)
  //     _amount--;
  //   else
  //     _amount = 0;

  //   _totalProductMoney = price * _amount;
  //   notifyListeners();
  // }

  void totalMoney() {
    _totalMoneyInCart = 0;
    for (var x in _cart) {
      _totalMoneyInCart += (x.amount * int.parse(x.product.price));
    }
    notifyListeners();
  }

  void clearProductInCart() {
    _cart.clear();
    notifyListeners();
  }

  void addProductToCart(Product p, int amount) {
    Cart c = Cart(p, amount);
    for (var c in _cart) {
      if (c.product.id == p.id) {
        c.amount += amount;
        _amount = c.amount;
        _totalProductMoney = int.parse(p.price) * _amount;
        notifyListeners();
        return;
      }
    }
    _amount = c.amount;
    _totalProductMoney = int.parse(p.price) * _amount;
    _cart.add(c);
    notifyListeners();
  }

  void minusProductInCart(Cart c) {
    _cart.removeWhere((e) => e.product.id == c.product.id);
    notifyListeners();
  }

  void increAmountProductInCart(Cart p) {
    for (var c in _cart) {
      if (c.product.id == p.product.id) {
        c.amount++;
        _amount = c.amount;
        notifyListeners();
        return;
      }
    }
  }

  void decreAmountProductInCart(Product p) {
    for (var c in _cart) {
      if (c.product.id == p.id) {
        if (c.amount == 1) {
          c.amount--;
          _amount = c.amount;
          _totalProductMoney = int.parse(p.price) * _amount;
          minusProductInCart(c);
          return;
        }
        c.amount--;
        _amount = c.amount;
        _totalProductMoney = int.parse(p.price) * _amount;
        notifyListeners();
        return;
      }
    }
  }
}

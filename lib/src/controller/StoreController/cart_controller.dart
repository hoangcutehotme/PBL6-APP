import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/model/product_model.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';

class CartController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Map<String, CartModel> _products = {};

  Map<String, CartModel> get products => _products;

  int get totalCart {
    var total = 0;
    _products.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }
  

  checkShowCart() {
    return products.isEmpty ? false : true;
  }

  addProduct(ProductModel product) {
    if (_products.containsKey(product.id)) {
      _products[product.id]!.quantity += 1;
    } else {
      _products.putIfAbsent(
          product.id,
          () => CartModel(
              images: product.images,
              price: product.price,
              id: product.id,
              name: product.name,
              storeId: product.storeId!,
              quantity: 1));
      CustomeSnackBar.showSuccessSnackTopBar(
          context: Get.context, title: 'Thông báo', message: 'Thêm thành công');
    }
    update();
  }

  removeProduct(ProductModel product) {
    if (_products.containsKey(product.id)) {
      if (_products[product.id]!.quantity == 1) {
        _products.removeWhere((key, value) => key == product.id);
        // _cart.removeWhere((key, value) => key == product.id);
      } else {
        // _cart[product.id]!.quantity -= 1;
        _products[product.id]!.quantity -= 1;
      }
    } else {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Thông báo', message: 'Không thể xoá ');
    }
    update();
  }

  addCart(String productId) {
    if (_products.containsKey(productId)) {
      _products[productId]!.quantity += 1;
    }
    update();
  }

  removeCart(String productId) {
    if (_products.containsKey(productId)) {
      if (_products[productId]!.quantity == 1) {
        _products.removeWhere((key, value) => key == productId);
      } else {
        _products[productId]!.quantity -= 1;
      }
    } else {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Thông báo', message: 'Không thể xoá ');
    }
    update();
  }

  updateNote(String productId, String note) {
    if (_products.containsKey(productId)) {
      _products[productId]!.notes = note;
    } else {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Thông báo', message: 'Không thể xoá ');
    }
    update();
  }
}





import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart {
   int? id;
  final String? productId;
  final String? productName;
  final String? productSize;
  final String? productColor;
  final int? productPrice;
  final RxInt? quantity;
  final String? image;
  Cart(
      { this.id,
        required this.productId,
        required this.productName,
        required this.productPrice,
        required this.productSize,
        required this.productColor,
        required this.quantity,
        required this.image});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        productSize = data['productSize'],
        productColor = data['productColor'],
        productPrice = data['productPrice'],
        quantity = RxInt(data['quantity']),
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productColor': productColor,
      'productSize': productSize,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'image': image,
    };
  }
}






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online/datas/product_data.dart';

class CartProduct {
  late String cid;
  String? category;
  late String pid;
  late int quantity;
  late String size;

  late ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document.get('category');
    pid = document.get('pid');
    quantity = document.get('quantity');
    size = document.get('size');
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData.toResumedMap(),
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online/datas/product_data.dart';

class CartProduct {
  String? cid;
  String? category;
  String? pid;
  int? quantity;
  String? size;

  ProductData? productData;

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document.get("category");
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
      "produdct": productData!.toResumeMap(),
    };
  }
}

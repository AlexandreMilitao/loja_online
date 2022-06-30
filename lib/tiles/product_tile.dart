import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/datas/product_data.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, this.type, required this.data})
      : super(key: key);

  final String? type;
  final ProductData data;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

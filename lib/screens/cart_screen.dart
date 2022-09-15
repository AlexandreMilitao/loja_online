import 'package:flutter/material.dart';
import 'package:loja_online/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                    '${p == null ? 0 : p} ${p == 1 ? "item" : "itens"}');
              },
            ),
          )
        ],
      ),
    );
  }
}

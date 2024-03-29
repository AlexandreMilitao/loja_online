import 'package:flutter/material.dart';
import 'package:loja_online/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  const CartPrice({Key? key, required this.buy}) : super(key: key);

  final VoidCallback buy;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child:
            ScopedModelDescendant<CartModel>(builder: (context, child, model) {
          double price = model.getProductsPrice();
          double discount = model.getDiscount();
          double ship = model.getShipPrice();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Resumo do Pedido',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Subtotal'),
                  Text("R\$ ${price.toStringAsFixed(2)}"),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Desconto'),
                  Text("R\$ ${discount.toStringAsFixed(2)}"),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Entrega'),
                  Text("R\$ ${ship.toStringAsFixed(2)}"),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "R\$ ${(price + ship - discount).toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              TextButton(
                onPressed: buy,
                child: const Text(
                  'Finalizar Pedido',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              )
            ],
          );
        }),
      ),
    );
  }
}

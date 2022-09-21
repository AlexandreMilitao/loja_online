import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key, required this.orderId}) : super(key: key);

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(orderId)
              .snapshots(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              int status = snapshot.data!['status'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Código do pedido: ${snapshot.data!.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    _buidProductsText(snapshot.data),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    'Status do Pedido:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", 'Preparação', status, 1),
                      Container(height: 1.0, width: 40.0, color: Colors.grey),
                      _buildCircle("2", 'Transporte', status, 2),
                      Container(height: 1.0, width: 40.0, color: Colors.grey),
                      _buildCircle("3", "Entrega", status, 3)
                    ],
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  String _buidProductsText(DocumentSnapshot? snapshot) {
    String text = "Descrição: \n ";
    for (LinkedHashMap p in snapshot!.get('products')) {
      text +=
          '${p['quantity']} x ${p['product']["title"]} (R\$ ${p['product']['price'].toStringAsFixed(2)}) \n';
    }
    text += 'Total: R\$ ${snapshot.get('totalPrice').toStringAsFixed(2)}';
    return text;
  }

  Widget _buildCircle(
      String title, String subTitle, int status, int thisStatus) {
    Color backColor;
    late Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey;
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.white;
      child = Icon(Icons.check);
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}

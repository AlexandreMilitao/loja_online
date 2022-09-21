import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  const DiscountCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom',
              ),
              initialValue: CartModel.of(context).couponCode,
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.exists) {
                    CartModel.of(context)
                        .setCupon(text, docSnap.get('percent'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Desconto de ${docSnap.get('percent')}% aplicado."),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  } else {
                    CartModel.of(context).setCupon(null, 0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cupom não existe"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

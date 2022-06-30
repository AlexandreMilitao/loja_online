import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../datas/product_data.dart';
import '../tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.snapshot}) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get("title")),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc(snapshot.id)
              .collection("itens")
              .get(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        type: "grid",
                        product: ProductData.fromDocument(
                            snapshot.data!.docs[index]),
                      );
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (contex, index) {
                      return ProductTile(
                        type: "list",
                        product: ProductData.fromDocument(
                            snapshot.data!.docs[index]),
                      );
                    },
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}

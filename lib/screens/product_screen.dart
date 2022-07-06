import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/datas/product_data.dart';
import 'package:loja_online/tabs/products_tab.dart';
import 'package:loja_online/tiles/product_tile.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  final ProductData product;

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  _ProductScreenState(this.product);
  String? size;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    final List imgList = product.images!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title!),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 0.9,
                  autoPlay: false,
                ),
                items: imgList
                    .map((item) => Center(
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ))
                    .toList()),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes!.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                color: s == size ? primaryColor : Colors.grey,
                                width: 3.0),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                      onPressed: size != null ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: const Text(
                        "Adicionar ao carrinho",
                        style: TextStyle(fontSize: 18.0),
                      )),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description!,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loja_online/screens/home_screen.dart';
import 'package:loja_online/screens/login_screen.dart';

import '../tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    const Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Flutter´s \nClothing",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Ola",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "Entre ou cadastre-se >",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(
                icon: Icons.home,
                text: "Inicio",
                controller: pageController,
                page: 0,
              ),
              DrawerTile(
                icon: Icons.list,
                text: "Produts",
                controller: pageController,
                page: 1,
              ),
              DrawerTile(
                icon: Icons.location_on,
                text: "Lojas",
                controller: pageController,
                page: 2,
              ),
              DrawerTile(
                  icon: Icons.playlist_add_check,
                  text: "Meus Pedidos",
                  controller: pageController,
                  page: 3)
            ],
          ),
        ],
      ),
    );
  }
}

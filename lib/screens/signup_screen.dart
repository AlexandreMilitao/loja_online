import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: "Nome Completo"),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Nome Inválido";
                }
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text!.isEmpty || !text.contains("@")) {
                  return "E-mail Inválido";
                }
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text) {
                if (text!.isEmpty || text.length < 6) {
                  return "Senha invalida";
                }
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(hintText: "Endereço"),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Endereço invalida";
                }
              },
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(primary: primaryColor),
                child: const Text(
                  "Criar Conta",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

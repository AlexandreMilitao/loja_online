import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addresController = TextEditingController();

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
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formkey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: "Nome Completo"),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Nome Inválido";
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
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
                  controller: _passController,
                  decoration: const InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (text) {
                    if (text!.isEmpty || text.length <= 7) {
                      return "Senha invalida";
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _addresController,
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
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _addresController.text,
                        };
                        model.singUP(
                          userData: userData,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
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
          );
        },
      ),
    );
  }

  void _onSuccess() {}
  void _onFail() {}
}

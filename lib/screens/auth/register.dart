import 'dart:convert';

import 'package:codepie/helper/constant.dart';
import 'package:codepie/methods/api.dart';
import 'package:codepie/screens/auth/login.dart';
import 'package:codepie/widget/input_field.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void registerUser() async {
    final data = {
      'email': email.text.toString(),
      'name': username.text.toString(),
      'password': password.text.toString(),
    };
    final result = await API().postRequest(route: '/register', data: data);
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = deviceWidth(context);
    double height = deviceHeight(context);
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spancer(h: height * 0.1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'DevSpace',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    spancer(
                      w: width * 0.05,
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: const Text(
                        '"Não seja apenas um espectador de soluções tecnológicas!"',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 28,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ),
                  ],
                ),
                spancer(
                  h: height * 0.15,
                ),
                InputField(
                  width: width,
                  controller: username,
                  hintText: 'Nome Completo',
                ),
                spancer(
                  h: height * 0.01,
                ),
                InputField(
                  width: width,
                  controller: email,
                  hintText: 'Email',
                ),
                spancer(
                  h: height * 0.01,
                ),
                InputField(
                    width: width,
                    controller: password,
                    hintText: 'Senha',
                    isObscure: true),
                spancer(
                  h: height * 0.03,
                ),
                spancer(
                  h: height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerRight,
                    padding: spacing(
                      h: 20,
                    ),
                    child: Container(
                      width: width * 0.3,
                      padding: spacing(
                        h: 10,
                        v: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Cadastrar',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          spancer(
                            w: 2,
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  children: [
                    Text(
                      'Já sou cadastrado!',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 18,
                      ),
                    ),
                    spancer(w: 4),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Efetuar Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

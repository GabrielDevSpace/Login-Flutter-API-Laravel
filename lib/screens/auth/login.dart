import 'dart:convert';

import 'package:codepie/helper/constant.dart';
import 'package:codepie/screens/auth/register.dart';
import 'package:codepie/screens/home.dart';
import 'package:codepie/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../methods/api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void loginUser() async {
    final data = {
      'email': email.text.toString(),
      'password': password.text.toString(),
    };
    final result = await API().postRequest(route: '/login', data: data);
    final response = jsonDecode(result.body);

    void showSnackBar() {
      var messageSnackBar = response['message'];
      var snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 150.0,
        duration: Duration(milliseconds: 1500),
        backgroundColor: Color.fromARGB(255, 45, 45, 45),
        content: Text('$messageSnackBar'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('token', response['token']);
      showSnackBar();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      showSnackBar();
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
                  isObscure: true,
                ),
                spancer(
                  h: height * 0.03,
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: const Text(
                    'Resgatar Senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                spancer(
                  h: height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    loginUser();
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
                        h: 20,
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
                            'Login',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          spancer(
                            w: 10,
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
                      'Seu primeiro acesso?',
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
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        'Cadastre-se',
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

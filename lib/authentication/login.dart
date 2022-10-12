import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inventory_1/authentication/Sign_up.dart';
import 'package:inventory_1/authentication/forgot_password.dart';
import 'package:inventory_1/managers/auth_manager.dart';
import 'package:inventory_1/managers/client_model.dart';
import 'package:inventory_1/utils/dimmension.dart';
import 'package:inventory_1/views/SalesPerson/dash.dart';
import 'package:inventory_1/views/SalesPerson/dashbord_sales.dart';
import '../views/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  final AuthManager _authManager = AuthManager();
  final ClientManager _clientManager = ClientManager();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _globalKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height10),
              children: [
                Center(
                    child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: Dimensions.font20 * 2,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(
                  height: Dimensions.height45,
                ),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        size: Dimensions.iconSize24,
                      ),
                      labelText: ('E-mail'),
                      labelStyle: TextStyle(fontSize: Dimensions.font16),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: Dimensions.width10 / 10)),
                      hintText: 'Enter your E-mail',
                      hintStyle: TextStyle(fontSize: Dimensions.font16),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: Dimensions.width10 / 10),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius15 - 10))),
                    ),
                    validator: (value) {
                      if (!emailRegExp.hasMatch(value!)) {
                        return 'Enter a valid e-mail!';
                      }

                      if (value.isEmpty) {
                        return 'Please enter an email address';
                      }
                    }),
                SizedBox(
                  height: Dimensions.height15,
                ),
                TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.visiblePassword,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: Dimensions.iconSize24,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: ('Password'),
                      labelStyle: TextStyle(fontSize: Dimensions.font16),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: Dimensions.width10 / 10)),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(fontSize: Dimensions.font16),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: Dimensions.width10 / 10),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius15 - 10))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password';
                      }

                      if (value.length < 6) {
                        return 'Password should not be less than 6 characters';
                      }
                    }),
                SizedBox(
                  height: Dimensions.height15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ForgotPassword();
                        }));
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 4, 82, 146),
                            fontSize: Dimensions.font16),
                        textAlign: TextAlign.right,
                      )),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 82, 146),
                        borderRadius: BorderRadius.circular(10)),
                    child: _authManager.isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : TextButton(
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                bool isSuccessfull =
                                    await _authManager.loginUser(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text);

                                if (isSuccessfull) {
                                  String uid =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  _clientManager
                                      .getClientInfo(uid)
                                      .then((value) {
                                    if (value!.role == "user") {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) {
                                        return Dash();
                                      }), (route) => false);

                                      Fluttertoast.showToast(
                                          msg: "Welcome Back",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      setState(() {
                                        _isLoading = false;
                                      });
                                    } else if (value.role == "admin") {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) {
                                        return Dashboard();
                                      }), (route) => false);

                                      Fluttertoast.showToast(
                                          msg: "You are not an Admin",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: _authManager.message,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "All fields are required!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.white),
                            ))),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Row(
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                          fontSize: Dimensions.font16, color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return const SignUp();
                          }), (route) => false);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 4, 82, 146),
                            fontSize: Dimensions.font16,
                          ),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}

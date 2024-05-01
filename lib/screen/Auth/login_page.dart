import 'package:dr_app/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  //output: if valid login to your account
  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState!.save();
      Provider.of<AuthProviderApp>(context, listen: false)
          .submitAuthForm(_userEmail.trim(), _userPassword.trim(), _userName.trim(), false, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
        Colors.lightBlue,
        Colors.purple,
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 55, vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                width: 3,
                                height: 25,
                                color: Colors.lightBlue,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  "Signup",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 35),
                                  child: TextFormField(
                                    key: ValueKey('email'),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty || !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _userEmail = value!;
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'email',
                                      helperText: '',
                                      prefixIcon: Icon(
                                        Icons.email,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 35),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    key: ValueKey('password'),
                                    validator: (String? value) {
                                      if (value!.isEmpty || value.length < 4) {
                                        return 'Password must be at least 4 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _userPassword = value!;
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'password',
                                      helperText: '',
                                      prefixIcon: Icon(
                                        Icons.lock_open,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        //Spacer(),
                    
                        //button
                        Container(
                          width: width * 0.5,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                              Colors.lightBlue,
                              Colors.purple,
                            ]),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: TextButton(
                            child: Text(
                              'LogIn',
                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () {
                              _trySubmit();
                              // Navigator.pushNamed(context, '/login');
                            },
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

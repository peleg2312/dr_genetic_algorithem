import 'package:dr_app/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';


  


  //output: if valid login to your account
  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState!.save();
      Provider.of<AuthProviderApp>(context, listen: false).submitAuthForm(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
          _isLogin,
          false,
          context);
    }
  }

  //output: new widget Stack with TextFormField
  Widget _nameWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          key: ValueKey('username'),
          validator: (value) {
            if (value!.isEmpty || value.length < 4) {
              return 'Please enter at least 4 characters';
            }
            return null;
          },
          onSaved: (value) {
            _userName = value!;
          },
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'username',
            helperText: '',
            prefixIcon: Icon(
              Icons.person,
            ),
          ),
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  //output: new widget Stack with TextFormField
  Widget _emailWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          key: ValueKey('email'),
          validator: (value) {
            if (value!.isEmpty || !value.contains('@')) {
              return 'Please enter a valid email address.';
            }
            return null;
          },
          onSaved: (value) {
            _userEmail = value!;
          },
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'email',
            helperText: '',
            prefixIcon: Icon(
              Icons.email,
            ),
          ),
        ),
      ],
    );
  }

  //output: new widget Stack with TextFormField
  Widget _passwordWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          key: ValueKey('password'),
          validator: (value) {
            if (value!.isEmpty || value.length < 4) {
              return 'Password must be at least 4 characters long.';
            }
            return null;
          },
          onSaved: (value) {
            _userPassword = value!;
          },
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'username',
            helperText: '',
            prefixIcon: Icon(
              Icons.password,
            ),
          ),
        ),
      ],
    );
  }

  //output: new widget Column with InkWell
  Widget _submitButton() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width * 0.5,
        height: height * 0.07,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.lightBlue,
                Colors.purple,
              ]),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: TextButton(
          child: Text(
            'SignUp',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: () {
            _trySubmit();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
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
                  height: height * 0.6,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 55, vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 3,
                              height: 25,
                              color: Colors.lightBlue,
                            ),
                            Text(
                              "Signup",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  _nameWidget(),
                                  _emailWidget(),
                                  _passwordWidget(),
                                  _submitButton(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Button
                      SizedBox(height: 10),
                      Container(
                        child: Column(
                          children: [
                            Text("Or SignUp Using"),
                            SizedBox(height: 12),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/icons/facebook.png",
                                      height: 40,
                                    ),
                                    Image.asset(
                                      "assets/icons/google.png",
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

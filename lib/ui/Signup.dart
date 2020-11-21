import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/ui/views/menu_view.dart';
import 'package:provider_architecture/ui/views/onboarding_view.dart';
import 'package:provider_architecture/ui/widgets/Login.dart';
import 'package:provider_architecture/ui/widgets/auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'dart:async';
import 'package:path/path.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State {
  final AuthService _auth = AuthService();


  final _formkey = GlobalKey<FormState>();
  bool _showPassword = false;
  File _image;
  String email = '';
  String name = '';
  String password = '';
  String error = '';
  bool loading = false;



  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;


    return  Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Chilanka',
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //
                    ),
                  ),

                  SizedBox(
                    height: (30),
                  ),
                  //

                  SizedBox(
                    height: (30),
                  ),
                  //
                  Container(
                      width: (400),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: (60),
                              ),
                              SizedBox(
                                height: (30),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                                autocorrect: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_rounded),
                                    isDense: true, // Added this
                                    contentPadding: EdgeInsets.all(
                                        (
                                            20)), // Added this
                                    labelText: " Email",
                                    hintText: " Email",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[350],
                                        fontWeight: FontWeight.w600),
                                    focusColor: Color(0xff0962ff),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xff0962ff)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey[350],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: (30),
                              ),
                              TextFormField(
                                  obscureText: !this._showPassword,
                                  validator: (value) => value.length < 6
                                      ? 'Enter a password 6+ chars long'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                    Icon(Icons.security_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: this._showPassword
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() =>
                                        this._showPassword =
                                        !this._showPassword);
                                      },
                                    ),
                                    isDense: true, // Added this
                                    contentPadding: EdgeInsets.all(
                                        (20)),
                                    labelText: " Password",
                                    hintText: " Passwoed",
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[350],
                                        fontWeight: FontWeight.w600),

                                    focusColor: Color(0xff0962ff),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xff0962ff)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey[350],
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height:(30),
                              ),
                              Text(
                                "Creating an account means you're okay with\nour Terms of Service and Privacy Policy",
                                style: TextStyle(
                                  fontFamily: 'Product Sans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                //
                              ),
                              InkWell(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 20),
                                    width: scrWidth * 0.5,
                                    height:(70),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[200],
                                      borderRadius:
                                      BorderRadius.circular(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                          fontFamily: 'ProductSans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    if (_formkey.currentState
                                        .validate()) {
                                      setState(() => loading = true);

                                      dynamic result = await _auth
                                          .registerWithemailAndPassword(
                                          email.trim(),
                                          password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                          'please supply a valid email';
                                          loading = false;
                                        });
                                      } else {
                                        SharedPreferences prefs =
                                        await SharedPreferences
                                            .getInstance();
                                        prefs.setString('email', email);

                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              transitionsBuilder:
                                                  (BuildContext context,
                                                  Animation<double>
                                                  animation,
                                                  Animation<double>
                                                  secanimtion,
                                                  Widget child) {
                                                animation =
                                                    CurvedAnimation(
                                                        parent: animation,
                                                        curve: Curves
                                                            .elasticInOut);
                                                return ScaleTransition(
                                                  alignment:
                                                  Alignment.center,
                                                  scale: animation,
                                                  child: child,
                                                );
                                              },
                                              transitionDuration:
                                              Duration(seconds: 1),
                                              pageBuilder:
                                                  (BuildContext context,
                                                  Animation<double>
                                                  animation,
                                                  Animation<double>
                                                  secanimtion) {
                                                return Login();
                                              }),
                                        );
                                      }
                                    }

                                    //Navigator.push(
                                    //context,
                                     //MaterialPageRoute(
                                     //builder: (context) => SideBarLayout()));
                                  }),
                              SizedBox(
                                height: (30),
                              ),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: 'Product Sans'),
                              ),
                            ],
                          ))),

                  SizedBox(
                    height: (30),
                  ),
                  /////////////////////////////////

                   RichText(
                     text: TextSpan(
                       children: [
                         TextSpan(
                           text: 'Already have an account? ',
                           style: TextStyle(
                             fontFamily: 'Product Sans',
                             fontSize: 15,
                             fontWeight: FontWeight.bold,
                             color: Colors.black.withOpacity(0.6),
                           ),
                         ),
                         TextSpan(
                           text: 'Sign In',
                           recognizer: TapGestureRecognizer()
                             ..onTap = () => Navigator.push(
                               context,
                               PageRouteBuilder(
                                   transitionsBuilder: (BuildContext
                                   context,
                                       Animation<double> animation,
                                       Animation<double> secanimtion,
                                       Widget child) {
                                     animation = CurvedAnimation(
                                         parent: animation,
                                         curve: Curves.elasticInOut);
                                     return ScaleTransition(
                                       alignment: Alignment.center,
                                       scale: animation,
                                       child: child,
                                     );
                                   },
                                   transitionDuration:
                                   Duration(seconds: 1),
                                   pageBuilder: (BuildContext context,
                                       Animation<double> animation,
                                       Animation<double> secanimtion) {
                                     return Login();
                                   }),
                             ),
                           style: TextStyle(
                             fontFamily: 'Product Sans',
                             fontSize: 15,
                             fontWeight: FontWeight.bold,
                             color: Colors.indigo[200],
                           ),
                         )
                       ],
                     ),
                   ),/////////////////////////////////////////////////////
                 ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Colors.indigo[400],
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              //
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Colors.indigo[200],
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
            ],
          ),
        ),
      );
  }
}



// ignore: must_be_immutable
// ignore: camel_case_types
@immutable
class Neu_button extends StatelessWidget {
  Neu_button({this.char});
  String char;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (50),
      height: (50),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Colors.lightBlue.withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

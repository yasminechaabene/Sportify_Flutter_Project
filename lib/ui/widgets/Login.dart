
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/ui/views/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Signup.dart';
//import '../size_service.dart';
import 'auth.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool _showPassword = false;
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    //initSizeConfigGlobal(context);

    return Scaffold(



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
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Chilanka',
                          fontSize: 35,
                          color: Color(0xff0C2551),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'Sign in with',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 15,
                          color: Colors.indigo[200],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: (30),
                  ),
                  //
                  // Container(
                  //   margin: EdgeInsets.only(left: 38),
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //           onTap: () async {
                  //             //_auth.googleSignIn();
                  //             _auth
                  //                 //.signInWithGoogle()
                  //                 .whenComplete(() async {
                  //               Navigator.of(context).push(
                  //                 //MaterialPageRoute(
                  //                   builder: (BuildContext context) {
                  //                     return SideBarLayout();
                  //                   },
                  //                 ),
                  //               );
                  //             });
                  //           },
                  //           child: Neu_button(
                  //             char: 'G',
                  //           )),
                  //       SizedBox(
                  //         width: 25,
                  //       ),
                  //       Neu_button(
                  //         char: 'f',
                  //       )
                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: (30),
                  ),

                  SizedBox(
                    height: (30),
                  ),
                  Container(
                      width: (400),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
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

                                    hintText: " Password",
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
                                height: (30),
                              ),
                              Text(
                                "Welcom",
                                style: TextStyle(
                                  fontFamily: 'Cardo',
                                  fontSize: 15.5,
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
                                    height: (70),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[200],
                                      borderRadius:
                                      BorderRadius.circular(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Login',
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
                                          .signInWithemailAndPassword(
                                          email.trim(), password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                          'Could not Sign In With Those Credentials';
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
                                                //return ScaleTransition(
                                                  //alignment:
                                                  //Alignment.center,
                                                  //scale: animation,
                                                  //child: child,
                                                //);
                                              },
                                              transitionDuration:
                                              Duration(seconds: 1),
                                              pageBuilder:
                                                  (BuildContext context,
                                                  Animation<double>
                                                  animation,
                                                  Animation<double>
                                                  secanimtion) {
                                                return OnBoardingView();
                                              }),
                                        );
                                      }
                                    }

                                    //Navigator.push(
                                    //context,
                                    // MaterialPageRoute(
                                    // builder: (context) => SideBarLayout()));
                                  }),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: 'Product Sans'),
                              ),
                            ],
                          ))),

                  // Container(
                  //   alignment: Alignment.center,
                  //   child: InkWell(
                  //     child: Text(
                  //       "Forgot Password?",
                  //       textAlign: TextAlign.left,
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 14,
                  //           fontFamily: 'Chilanka',
                  //           fontWeight: FontWeight.w900),
                  //     ),
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         PageRouteBuilder(
                  //             transitionsBuilder: (BuildContext context,
                  //                 Animation<double> animation,
                  //                 Animation<double> secanimtion,
                  //                 Widget child) {
                  //               animation = CurvedAnimation(
                  //                   parent: animation,
                  //                   curve: Curves.elasticInOut);
                  //               return ScaleTransition(
                  //                 alignment: Alignment.center,
                  //                 scale: animation,
                  //                 child: child,
                  //               );
                  //             },
                  //             transitionDuration: Duration(seconds: 1),
                  //             pageBuilder: (BuildContext context,
                  //                 Animation<double> animation,
                  //                 Animation<double> secanimtion) {
                  //                 return OnBoardingView();
                  //               //return Forgot();
                  //             }),
                  //       );
                  //     },
                  //   ),
                  // ),

                  SizedBox(
                    height: (30),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don t have account? ',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
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
                                    return SignUp();
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
                  ),
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
    //);
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
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 20,
            color: Colors.indigo[200],
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
            color: Colors.indigo[200],
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

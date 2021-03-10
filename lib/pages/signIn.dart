import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_system/helper/helperfunctions.dart';
import 'package:smart_home_system/services/auth.dart';
import 'package:smart_home_system/services/database.dart';
import 'package:smart_home_system/widgets/widget.dart';
import 'package:smart_home_system/model/user.dart';
import 'package:smart_home_system/input_page.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  signIn() async {
    if (formKey.currentState.validate()) {
      /* Map<String,String> userMap={
        "name":userNameTextController.text,
        "email":emailTextController.text
      };*/
      //HelperFunctions.saveUserNameSharedPreference(userNameTextController.text);
      HelperFunctions.saveUserEmailSharedPreference(emailTextController.text);

      setState(() {
        loading = true;
      });
      QuerySnapshot userInfo=await databaseMethods.getUserNameByEmail(emailTextController.text);
      HelperFunctions.saveUserNameSharedPreference(userInfo.docs[0].get("name"));
      Users value = await authMethods.signInWithEmailAndPassword(
          emailTextController.text, passwordTextController.text);
      if (value != null) {
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputPage(userInfo.docs[0].get("name")),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height - 50.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
                              r"@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                              ? null
                              : "input correct email";
                        },
                        controller: emailTextController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        style: simpleTextStyle(),
                        validator: (value) {
                          return value.length > 6
                              ? null
                              : "password is invalid";
                        },
                        controller: passwordTextController,
                        decoration: textFieldInputDecoration("password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Forgot Password ?",
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      /* gradient: LinearGradient(
                        colors: [
                          const Color(0xff007ef4),
                          const Color(0xff2a758c),
                        ],
                      ),*/
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                /* Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: simpleTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

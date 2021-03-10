//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_system/helper/helperfunctions.dart';
import 'package:smart_home_system/services/auth.dart';
import 'package:smart_home_system/services/database.dart';
import 'package:smart_home_system/widgets/widget.dart';
import 'package:smart_home_system/model/user.dart';
import 'package:smart_home_system/input_page.dart';
class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();

  TextEditingController userNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  signMeUp() async{
    if (formKey.currentState.validate()) {

      Map<String,String> userMap={
        "name":userNameTextController.text,
        "email":emailTextController.text
      };
      HelperFunctions.saveUserNameSharedPreference(userNameTextController.text);
      HelperFunctions.saveUserEmailSharedPreference(emailTextController.text);

      setState(() {
        loading = true;
      });
      Users value = await authMethods
          .signUpWithEmailAndPassword(
          emailTextController.text, passwordTextController.text);
      //print("${value.userId}");
      databaseMethods.uploadUserInfo(userMap);
      if(value!=null){
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>InputPage(userNameTextController.text),));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: loading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      )
          : SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height - 50.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty || value.length < 4
                              ? "input is incorrect"
                              : null;
                        },
                        controller: userNameTextController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("username"),
                      ),
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
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      //TODO
                      signMeUp();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            /*const Color(0xff007ef4),
                                  const Color(0xff2a758c),*/
                            Colors.blue[400],
                            Colors.blue[600],
                            Colors.blue[900],

                          ],
                        ),
                        //color: Colors.red[900],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "Sign Up",
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
                  /*Container(
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
                            "Sign Up with Google",
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
                        "Already have an account ?",
                        style: simpleTextStyle(),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0,),
                          child: Text(
                            "SignIn Now",
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
      ),
    );
  }
}

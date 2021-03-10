import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    elevation: 0,
    //backgroundColor: Color(0xff007ef4),
    flexibleSpace: Container(
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
      ),
    ),
    title: Text(
      'Smart Home',
      style: GoogleFonts.pacifico(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white,),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white,),
    ),
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );
}
import 'package:flutter/material.dart';
const klabeltextstyle=TextStyle(
  color: Color(0xFF8D8E98),
  fontSize: 18.0,
);
const kNumbertextstyle=TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);
const kBottomcardcolour =Color(0xFFEB1555);
Color kactivecardcolour=  Colors.lightBlue[100];
// Color(0xFF1D2136);
const kinactivecardcolour=Color(0xFF111328);
const kbottomcardheight=80.0;

const kLargetextstyle=TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);
const kTitletextstyle=TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);
const kResulttextstyle=TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);
const kBMItextstyle=TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);
const kMessagetextstyle=TextStyle(
  fontSize: 22.0,
);

Decoration kactiveDecoration=BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xffffffff), Color(0xff0d4781)]
  ),
  borderRadius: BorderRadius.circular(10.0),
);

Decoration kinactiveDecoration=BoxDecoration(
    gradient: new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 25,178,238),
        Color.fromARGB(255, 21,236,229)
      ],
    ),
  borderRadius: BorderRadius.circular(10.0),
);
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:smart_home_system/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'input_page.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_system/helper/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_home_system/helper/helperfunctions.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase database=FirebaseDatabase();
  database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // precacheImage(AssetImage('assets/home.png'), context);
//     // precacheImage(AssetImage('assets/g-logo.png'), context);
//     // precacheImage(AssetImage('assets/dashboard.png'), context);
//     // precacheImage(AssetImage('assets/empty.png'), context);
//
//     // return MaterialApp(
//     //   title: 'Automate',
//     //   debugShowCheckedModeBanner: false,
//     //   // theme: ThemeData(
//     //   //   primarySwatch: Colors.indigo,
//     //   // ),
//     //
//     //   theme: new ThemeData(
//     //       primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
//     //       primarySwatch: Colors.grey),
//     //   // home: MyHomePage(title: 'Automate'),
//     //   // home: GoogleAuth(),
//     //   // initialRoute: '/',
//     //   // routes: {
//     //   //   '/': (context) => MyHomePage(),
//     //   //},
//     //   //
//     //   home: MyHomePage("Automate"),
//     // );
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(
//         primaryColor: Color(0xFFFFFFFF),
//         scaffoldBackgroundColor: Color(0xFFFFFFFF),
//         // Color(0xFFFCFCFD),
//       ),
//       //home: MyHomePage("Automate"),
//       home: InputPage(),
//     );
//   }
// }
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn=false;
  String userName="xyz";
  @override
  void initState() {
    // TODO: implement initState
    getLoggedInStatus();
    super.initState();
  }
  /*void dispose(){
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    super.dispose();
  }*/
  getLoggedInStatus() async{
    bool value=
    await HelperFunctions.getUserLoggedInSharedPreference();
    String value1=await HelperFunctions.getUserNameSharedPreference();
    print(value);
    print(value1);
    setState(() {
      userLoggedIn=value;
      userName=value1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.black26,//Color(0xff1f1f1f),
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userLoggedIn==false || userLoggedIn==null ?  Authenticate():InputPage(userName) ,
    );
  }
}
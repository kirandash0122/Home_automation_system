import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// plugins
import 'package:firebase_database/firebase_database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

//pages
import 'pages/firebase_list_view.dart';
import 'pages/options.dart';
import 'models/device.dart';
import 'widgets/widget.dart';
import 'package:smart_home_system/helper/helperfunctions.dart';
import 'package:smart_home_system/helper/constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title,this.userName);

  final String title;
  final String userName;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final mainReference = FirebaseDatabase.instance.reference();

class _MyHomePageState extends State<MyHomePage> {
  List<DeviceEntry> devices = new List();
  String _connectionStatus;
  //String userName="xyz";
  // getUserName() async {
  //   Constants.myName= await HelperFunctions.getUserEmailSharedPreference();
  //
  //   // print(userName);
  //   // print(userName);
  //   // print(userName);
  //   // print(userName);
  // }

  // SharedPreferences prefs;
  // String id = '';
  // String nickname = '';
  // String email = '';
  // String photoUrl = '';

  //_MyHomePageState() {}

  _onEntryAdded(Event event) {
    setState(() {
      devices.add(DeviceEntry.fromSnapshot(event.snapshot));
    });
  }

  _onEntryRemoved(Event event) {
    setState(() {
      devices.removeWhere((entry) => entry.key == event.snapshot.key);
    });
  }

  _onEntryEdited(Event event) {
    var oldValue =
    devices.singleWhere((entry) => entry.key == event.snapshot.key);
    setState(() {
      devices[devices.indexOf(oldValue)] =
      new DeviceEntry.fromSnapshot(event.snapshot);
    });
    // print(devices); .child(widget.userName)
  }

  void readLocal() async {
    mainReference.child(widget.userName).child('bedroom').onChildAdded.listen(_onEntryAdded);
    mainReference.child(widget.userName)
        .child('bedroom')
        .onChildChanged
        .listen(_onEntryEdited);
    mainReference.child(widget.userName)
        .child('bedroom')
        .onChildRemoved
        .listen(_onEntryRemoved);
    setState(() {});
  }

  StreamSubscription<ConnectivityResult> _connectionSubscription;

  @override
  void initState() {
    //getUserName();
    super.initState();

    readLocal();
    print(widget.userName);
    //print(Constants.myName);
    _connectionSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setState(() {
        _connectionStatus = result.toString();
        // print("Connection : $_connectionStatus");
      });
    });

    // print(id);
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  Widget topAppBar(BuildContext context,String userName) {
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
          widget.title,
        style: GoogleFonts.pacifico(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => OptionsPage(room : "bedroom",userName: userName,)));
          },
        )
      ],
    );
  }

  _makeBottom(BuildContext context) {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            // IconButton(
            //   icon: Icon(Icons.blur_on, color: Colors.white),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.hotel, color: Colors.white),
            //   onPressed: () {},
            // ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => AccountPage()));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (devices.length != 0) {
    //   print(devices[0].name);
    // }
    if (_connectionStatus == ConnectivityResult.mobile.toString() ||
        _connectionStatus == ConnectivityResult.wifi.toString()) {
      return Scaffold(
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        backgroundColor: Color(0xFFFFFFFF),
        // bottomNavigationBar: _makeBottom(context),
        appBar: topAppBar(context,widget.userName),
        body: FirebaseListView(
          documents: devices,
          room: "bedroom",
          userName: widget.userName,
        ),
      );
    } else {
      return Scaffold(
        //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
       backgroundColor: Color(0xFFFFFFFF),
        // bottomNavigationBar: _makeBottom(context),
        appBar: topAppBar(context,widget.userName),
        body: Container(
          child: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No connection',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}


///here we go
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   bool value=false;
//   final dbRef=FirebaseDatabase.instance.reference();
//   onUpdate(){
//     setState(() {
//       value=!value;
//     });
//   }
//   Future<void> onWrite(){
//    dbRef.child("bedroom").child("devices").set({
//      "switch" : !value,
//    });
//   }
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown
//     ]);
//     return Scaffold(
//       body: Column(
//         children: [
//           FloatingActionButton.extended(
//               onPressed: (){
//                 onUpdate();
//                 onWrite();
//               },
//               label: Text("ON"),
//             elevation: 20,
//             backgroundColor: Colors.yellow,
//           ),
//         ],
//       ),
//     );
//
//   }
//
// }

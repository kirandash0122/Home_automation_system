import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// plugins
import 'package:firebase_database/firebase_database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

//pages
import 'helper/helperfunctions.dart';
import 'pages/firebase_list_view.dart';
import 'pages/options.dart';
import 'models/device.dart';
import 'widgets/widget.dart';

class MyKitchenPage extends StatefulWidget {
  MyKitchenPage(this.title,this.userName);

  final String title;
  final String userName;

  @override
  _MyKitchenPageState createState() => _MyKitchenPageState();
}

final mainReference = FirebaseDatabase.instance.reference();

class _MyKitchenPageState extends State<MyKitchenPage> {
  List<DeviceEntry> devices = new List();
  String _connectionStatus;
  //String userName="xyz";
  // getUserName() async {
  //   userName= await HelperFunctions.getUserNameSharedPreference();
  // }
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
    // print(devices);
  }

  void readLocal() async {
    mainReference.child(widget.userName).child('kitchen').onChildAdded.listen(_onEntryAdded);
    mainReference.child(widget.userName)
    .child('kitchen')
        .onChildChanged
        .listen(_onEntryEdited);
    mainReference.child(widget.userName)
        .child('kitchen')
        .onChildRemoved
        .listen(_onEntryRemoved);
    setState(() {});
  }

  StreamSubscription<ConnectivityResult> _connectionSubscription;

  @override
  void initState() {
    super.initState();

    readLocal();
    //getUserName();
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
                builder: (BuildContext context) => OptionsPage(room: "kitchen",userName: userName,)));
          },
        )
      ],
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
            room :"kitchen",
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

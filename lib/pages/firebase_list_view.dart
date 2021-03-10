import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ?

import 'package:smart_home_system/models/device.dart';
import 'package:google_fonts/google_fonts.dart';

DatabaseReference mainReference = FirebaseDatabase.instance.reference();

class FirebaseListView extends StatelessWidget {
  final documents;
  final String room;
  final String userName;
  //final id;
  FirebaseListView({this.documents,this.room,this.userName});

  String _findIcon(title) {
    String a = "https://i.imgur.com/O774D8O.png";
    switch (title) {
      case "AC":
        a = "https://i.imgur.com/O774D8O.png";
        break;
      case "HEATER":
        a = "https://i.imgur.com/Yljp3a9.png";
        break;
      case "FAN":
        a = "https://i.imgur.com/gvwNMq0.png";
        break;
      case "LED":
      case "TUBELIGHT":
        a = "https://i.imgur.com/5G2G8Aq.png";
        break;
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
    // print(documents);
    if (documents.length != 0) {
      return SizedBox(
          height: 400,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              DeviceEntry object = documents[index];
              // print(object);
              String title = object.name;
              //int size= title.length;
              //String overTitle= title.substring(size);
              //print(overTitle);
              // print(title);
              bool status = object.status;
              String url = _findIcon(title);
              Color c = (status == true) ? Color(0xff64b5f6) : Color(0XFFE3F2FD);
              Color iconColor = (status == true) ? Colors.greenAccent : Color(0xff64b5f6);
              Color titleColor= (status == true) ? Colors.white : Color(0xff64b5f6);
              // return Container(
              //   height: 30,
              //   width: 40,
              //   child : Text(title),
              // );
              // return Card(
              //   elevation: 4.0,
              //   margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              //   color: c,
              //   child: InkWell(
              //     onTap: () {
              //       status = !status;
              //       mainReference
              //           .child('devices')
              //           .child(object.key)
              //           .set({"name": title, "status": status});
              //     },
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Color.fromRGBO(64, 75, 96, .9),
              //       ),
              //       child: SizedBox(
              //         width: 100,
              //         child: ListTile(
              //           leading: CachedNetworkImage(
              //             imageUrl: url,
              //             // placeholder: new CircularProgressIndicator(),
              //             //errorWidget: new Icon(Icons.error),
              //             height: 32.0,
              //           ),
              //           contentPadding:
              //           EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              //           title: Text(
              //             title,
              //             style: TextStyle(
              //                 color: Colors.white, fontWeight: FontWeight.bold),
              //           ),
              //           subtitle: Row(
              //             children: <Widget>[
              //               Container(
              //                   padding: const EdgeInsets.all(6.0),
              //                   decoration: new BoxDecoration(
              //                     shape: BoxShape.circle,
              //                     color: iconColor,
              //                   )),
              //               // Text("", style: TextStyle(color: Colors.white))
              //             ],
              //           ),
              //           trailing: Switch(
              //             activeColor: Colors.white,
              //             value: status,
              //             onChanged: (e) {
              //               status = !status;
              //               mainReference
              //                   .child('devices')
              //                   .child(object.key)
              //                   .set({"name": title, "status": status});
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // );
              return Container(
                padding: EdgeInsets.all(10.0),
                color: c,
                // child: ListTile(
                //               leading: CachedNetworkImage(
                //                 imageUrl: url,
                //                 //placeholder: new CircularProgressIndicator(),
                //                 //errorWidget: new Icon(Icons.error),
                //                 height: 32.0,
                //               ),
                //               contentPadding:
                //               EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                //               title: Text(
                //
                //                 title,
                //                 //'title',
                //                 style: GoogleFonts.pacifico(
                //                   textStyle: TextStyle(
                //                     color: titleColor, fontWeight: FontWeight.bold,
                //                     // color: Colors.white,
                //                     fontSize: 20.0,
                //                     //fontWeight: FontWeight.w700,
                //                   ),
                //                 ),
                //                 // style: TextStyle(
                //                 //     color: titleColor, fontWeight: FontWeight.bold),
                //               ),
                //               subtitle: Row(
                //                 children: <Widget>[
                //                   Container(
                //                       padding: const EdgeInsets.all(6.0),
                //                       decoration: new BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: iconColor,
                //                       )),
                //                   // Text("", style: TextStyle(color: Colors.white))
                //                 ],
                //               ),
                //               trailing: Switch(
                //                 activeColor: Colors.white,
                //                 inactiveThumbColor: Color(0xff64b5f6),
                //                 value: status,
                //                 onChanged: (e) {
                //                   status = !status;
                //                   mainReference.child(userName)
                //                   .child(room)   // abhi kia add
                //                       .child(object.key)
                //                       .set({"name": title, "status": status});
                //                       //.set({"status" : status});
                //                 },
                //               ),
                //             ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  CachedNetworkImage(
                                  imageUrl: url,
                                  //placeholder: new CircularProgressIndicator(),
                                  //errorWidget: new Icon(Icons.error),
                                  height: 32.0,
                                ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Text(

                                      title,
                                      //'title',
                                      style: GoogleFonts.pacifico(
                                        textStyle: TextStyle(
                                          color: titleColor, fontWeight: FontWeight.bold,
                                          // color: Colors.white,
                                          fontSize: 20.0,
                                          //fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // style: TextStyle(
                                      //     color: titleColor, fontWeight: FontWeight.bold),
                                    ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    padding: const EdgeInsets.all(6.0),
                                                    decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: iconColor,
                                                    )),
                                                // Text("", style: TextStyle(color: Colors.white))
                                              ],
                                            ),
                          ],
                        ),
                Switch(
                                  activeColor: Colors.white,
                                  inactiveThumbColor: Color(0xff64b5f6),
                                  value: status,
                                  onChanged: (e) {
                                    status = !status;
                                    mainReference.child(userName)
                                    .child(room)   // abhi kia add
                                        .child(object.key)
                                        .set({"name": title, "status": status});
                                        //.set({"status" : status});
                                  },
                                ),
                    GestureDetector(
                      onTap: (){
                        mainReference.child(userName)
                            .child(room)   //
                            .child(object.key).remove();
                        //.set({"status" : status});
                      },
                      child: Icon(
                        Icons.close,
                        size:40.0,
                        color: Colors.red[800],
                      ),
                    ),
                    
                  ],
                ),
              );
            },
          ),
        );
    } else {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'No devices',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              // SizedBox(height: 30.0),
              // Image.asset(
              //   'assets/empty.png',
              //   height: 200.0,
              // ),
              // FadeInImage(
              //   placeholder: MemoryImage(kTransparentImage),
              //   image: Image.network('https://picsum.photos/250?image=9'),
              //   // AssetImage('assets/empty.png'),
              //   height: 200.0,
              // ),
            ]),
      );
    }
  }
}
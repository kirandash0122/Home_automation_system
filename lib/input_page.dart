import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home_system/home.dart';
import 'package:smart_home_system/kitchen.dart';
import 'package:smart_home_system/hallroom.dart';
import 'package:smart_home_system/bathroom.dart';
import 'components/reusable_card.dart';
import 'components/icon_content.dart';
import 'constants.dart';
import 'components/buttom_button.dart';
import 'components/roundicon_button.dart';
import 'widgets/widget.dart';
enum Room{
  bedRoom,
  kitchen,
  bathRoom,
  hallRoom
}

class InputPage extends StatefulWidget {
  final String userName;
  InputPage(this.userName);
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Room selectedRoom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color(0xFFFFFFFF),
      //   title: Row(
      //     children: [
      //       Text('Smart Home ',
      //       style: TextStyle(color: Color(0xff669df4),fontSize: 25.0,fontWeight: FontWeight.bold),
      //       ),
      //       // Icon(
      //       //   FontAwesomeIcons.home,
      //       //   size:18.0,
      //       //   color: Colors.white,
      //       // ),
      //       // SizedBox(
      //       //   width: 170.0,
      //       // ),
      //       // Icon(
      //       //   FontAwesomeIcons.signOutAlt,
      //       //   size:22.0,
      //       //   color: Colors.white,
      //       // ),
      //     ],
      //   ),
      // ),
      appBar: appBarMain(context),
      body: Column(
        children: [
          SizedBox(
            height: 60.0,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                            onpress: (){
                            setState(() {
                            selectedRoom=Room.bedRoom;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage("BedRoom",widget.userName)),
                            );
                            },
                          decoration: selectedRoom==Room.bedRoom?
                          BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[Color(0xff64b5f6), Color(0xff0d4781)]
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ) :
                          BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[Color(0XFFE3F2FD), Color(0XFFE3F2FD)]
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          cardchild: Iconcontent(content: FontAwesomeIcons.bed,contenttext: 'Bedroom',active: selectedRoom==Room.bedRoom,),
                        ),
                ),
                Expanded(
                  child: ReusableCard(
                    onpress: (){
                      setState(() {
                        selectedRoom=Room.kitchen;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyKitchenPage("kitchen",widget.userName)),
                      );
                    },
                    decoration: selectedRoom==Room.kitchen?
                    BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0xff64b5f6), Color(0xff0d4781)]
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ) :
                    BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0XFFE3F2FD), Color(0XFFE3F2FD)]
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    cardchild: Iconcontent(content: FontAwesomeIcons.utensils,contenttext: 'Kitchen',active: selectedRoom==Room.kitchen,),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onpress: (){
                      setState(() {
                        selectedRoom=Room.bathRoom;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyBathPage("bathroom",widget.userName)),
                      );
                    },
                    decoration: selectedRoom==Room.bathRoom?
                    BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0xff64b5f6), Color(0xff0d4781)]
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ) :
                    BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0XFFE3F2FD), Color(0XFFE3F2FD)]
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    cardchild: Iconcontent(content: FontAwesomeIcons.shower,contenttext: 'Bathroom',active: selectedRoom==Room.bathRoom,),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onpress: (){
                      setState(() {
                        selectedRoom=Room.hallRoom;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHallPage("hallroom",widget.userName)),
                      );
                    },
                    decoration: selectedRoom==Room.hallRoom?
                    BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0xff64b5f6), Color(0xff0d4781)]
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ) :
                    BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0XFFE3F2FD), Color(0XFFE3F2FD)]
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    cardchild: Iconcontent(content: FontAwesomeIcons.couch,contenttext: 'Hall Room',active: selectedRoom==Room.hallRoom,),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60.0,
          )
        ],
      ),
    );
  }
}


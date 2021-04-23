import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guruapp/Screen/subjectScreen.dart';
import 'package:guruapp/widgets/widget.dart';

class MainScreen extends StatefulWidget {
  final List classdata;
  final List subjectdata;
  final userID;

  MainScreen({Key key, this.classdata, this.subjectdata, this.userID})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var classid;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // ignore: unused_field
  int _classid;

  @override
  Widget build(BuildContext context) {
    List newclass = widget.classdata;
    List subjectname = widget.subjectdata;
    var userinfo = widget.userID;

    print(userinfo);
    print(newclass);
    print(subjectname);

    return WillPopScope(
      onWillPop: onbackpressed,
            child: Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            backgroundColor: Color(0xff17181c),
            appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Select Class", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            ),
            body: Container(
              
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                
                image: AssetImage("assets/images/img3.png"),
                //fit: BoxFit.cover,
                fit:BoxFit.fill,
              ),
            ),
            child: Center(
              child: Container(
                width: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newclass.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff72327c),
                          const Color(0xffba3395),
                        ]),
                        borderRadius: BorderRadius.circular(10)),
                        child: new GestureDetector(
                        onTap: () {
                        setState(() {
                          _classid = index;
                          // ignore: unused_local_variable
                          final fruitMap = newclass.asMap();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubjectScreen(
                                        classs: newclass,
                                        subject: subjectname,
                                        id: newclass[index]["id"].toString(),
                                        userID: userinfo,
                                      )));
                              });
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff72327c),
                          const Color(0xffba3395),
                        ]),
                        borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            newclass[index]["class"] + "th",
                            style: mediumTextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
                      ),
                  ),
          );
         }        
      
        Future<bool> onbackpressed() {
          exit(0);
  }
}

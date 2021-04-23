import 'package:flutter/material.dart';
import 'package:guruapp/Screen/profile.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';

import 'package:guruapp/Screen/selectTopicScreen.dart';

class NavigationScreen extends StatefulWidget {
  final String teacherID;
  final String classID;
  final String subjectID;
  final useriD;
  final List data;

  const NavigationScreen(
      {Key key,
      @required this.teacherID,
      this.classID,
      this.subjectID,
      this.useriD,
      this.data})
      : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var teacherList;
  var userinfo;
  String classid;
  String subjectid;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    teacherList = widget.teacherID;
    userinfo = widget.useriD;
    print(userinfo);
    classid = widget.classID;
    print(classid);
    subjectid = widget.subjectID;
    print(subjectid);

    final List<Widget> _children = [
      SelectTopicScreen(data: widget.data),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor:  Color(0xff17181c),
      body: _children[_currentIndex], // new
      bottomNavigationBar: ClipRRect(
                   clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),

      child: Container(
            child: GradientBottomNavigationBar(
                  backgroundColorStart:  const Color(0xffe87233),
                  backgroundColorEnd:const Color(0xffd1225a),
                  onTap: onTabTapped, // new
                  currentIndex: _currentIndex, // new
                  items: [
                  new BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Colors.white,),
                // ignore: deprecated_member_use
                  title: Text('Home',style: TextStyle(color: Colors.white),),
              ),
                  new BottomNavigationBarItem(
                  icon: Icon(Icons.person,color: Colors.white,),
                  // ignore: deprecated_member_use
                  title: Text('Profile',style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

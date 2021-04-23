import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guruapp/Screen/selectTeacherScreen.dart';
import 'package:http/http.dart' as http;
import 'package:guruapp/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectScreen extends StatefulWidget {
  final List subject;
  final List classs;
  final String id;
  final userID;

  const SubjectScreen(
      {Key key, @required this.subject, this.classs, this.id, this.userID})
      : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // ignore: unused_field
  int _id;
  String subjectid;
  var teacherlist;
  List teacherListData;

  @override
  Widget build(BuildContext context) {
    List subjectdata = widget.subject;
    // ignore: unused_local_variable
    List classdata = widget.classs;

    //classid
    String classid = widget.id;
    print(classid);

    var userinfo = widget.userID;
    print(userinfo);

    getTeacherList() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access');
      print(accessToken);

      var response = await http.get(
          Uri.parse(
              'http://myguruji.org/insight/tutorials-dev/public/api/auth/get_teachers' +
                  "/" +
                  classid +
                  "/" +
                  subjectid),
          headers: {
            "Authorization": "Bearer " + accessToken,
            "cache-control": "no-cache"
          });
      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      Map mapRes = json.decode(response.body);
      final data = mapRes['data'] as Map;
      // ignore: unused_local_variable
      for (final name in data.keys) {
        teacherlist = data["teachers"];
        teacherListData = teacherlist;
      }
      if (statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectTeacherScreen(
                      teacheruser: teacherListData,
                      classId: classid,
                      subjectId: subjectid,
                      userID: userinfo,
                    )));
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff17181c),
      appBar: AppBar(
      automaticallyImplyLeading: false,

        title: Text("Select Subject", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/img5.png"),
              fit:BoxFit.fill,
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 100),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: subjectdata.length,
             // physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => Container(
                alignment: Alignment.center,
                width: 300,
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xffe03e4d),
                      const Color(0xffd1225a),
                      const Color(0xffe87233),
                    ]),
                    borderRadius: BorderRadius.circular(15)),
                child: new GestureDetector(
                  onTap: () {
                    setState(() {
                      _id = index;
                      //subjectid
                      subjectid = subjectdata[index]["id"].toString();
                      print(subjectid);

                      getTeacherList();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectTeacherScreen(teacheruser: null,)));
                    });

                    // _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("You clicked item number $_id")));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xffe03e4d),
                      const Color(0xffd1225a),
                      const Color(0xffe87233),
                    ]),
                    borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        subjectdata[index]["subject_name"],
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
    );
  }
}

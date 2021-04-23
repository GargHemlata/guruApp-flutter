import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruapp/Screen/bottomNavigationScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChapterScreen extends StatefulWidget {
  final List chapteruser;  
  final List teacheruser;
  final String classId;
  final String subjectId;
  final String id;
  final userID;


  const ChapterScreen({
    Key key,
    @required 
    this.chapteruser,
    this.teacheruser,
    this.classId,
    this.subjectId,
    this.userID,
    this.id,
  }) : super(key: key);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  // ignore: unused_field
  int _id;
  String teacherid;

  @override
  Widget build(BuildContext context) {

    List teacherList = widget.teacheruser;
    var userinfo = widget.userID;
    String userid = userinfo["id"].toString();
    String classid = widget.classId;
    print(classid);
    String subjectid = widget.subjectId;
    print(subjectid);

    print(userinfo);



    getChapterList() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access');
      print(accessToken);

      var response = await http.get(
          Uri.parse(
            'http://myguruji.org/insight/tutorials-dev/public/api/auth/get_chapters' +
                "/" +
                classid +
                "/" +
                subjectid +
                "/" +
                teacherid,
          ),
          headers: {
            "Authorization": "Bearer " + accessToken,
            "cache-control": "no-cache"
          });

          int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      Map mapRes = json.decode(response.body);
      List data = mapRes['data'] as List;

      if (statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NavigationScreen(
                      teacherID: teacherid,
                      classID: classid,
                      subjectID: subjectid,
                      useriD: userid,
                      data: data,
                    )
                // SelectTopicScreen(data: data,
                //   )
                ));
      }

    }





    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff17181c),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Select Chapter", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),

       body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 130),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/img1.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new GestureDetector(
              onTap: () {},
              child: ListView.builder(
                  itemCount: teacherList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Color(0xff17181c),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Card(
                        color: Color(0xff040706),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(children: [
                            Container(
                              width: 55.0,
                              height: 65.0,
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.purple,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.black,
                                    backgroundImage: AssetImage(
                                        'assets/images/gurujilogo.png'),
                                  )),
                            ),
                            new GestureDetector(
                              onTap: () {
                                setState(() {
                                  _id = index;
                                  teacherid =
                                      teacherList[index]["id"].toString();
                                  print(teacherid);
                                  getChapterList();
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 220,
                                color: Color(0xff040706),
                                  padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 14.0),
                                  child: Text(
                                    teacherList[index]["teacher_name"],
                                    style: mediumTextStyle(),
                                  )),
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
          ),
       ),
       );
  }
}
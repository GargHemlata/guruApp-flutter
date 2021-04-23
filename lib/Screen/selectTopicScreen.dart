import 'package:flutter/material.dart';
//import 'package:guruapp/Screen/profile.dart';
import 'package:guruapp/Screen/youtubeVideoPalyerScreen.dart';

import 'package:guruapp/widgets/widget.dart';

class SelectTopicScreen extends StatefulWidget {
  final List data;

  const SelectTopicScreen({
    Key key,
    this.data,
  }) : super(key: key);
  @override
  _SelectTopicScreenState createState() => _SelectTopicScreenState();
}

class _SelectTopicScreenState extends State<SelectTopicScreen> {
  var isLoading = false;
  

  @override
  Widget build(BuildContext context) {
    List topicdata = widget.data;
    // ignore: unused_local_variable
    var videoname, parts;
    var videoCode;

    return Scaffold(
      backgroundColor: Color(0xff17181c),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Physics Topics",
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffe03e4d),
                  const Color(0xffd1225a),
                  const Color(0xffe87233),
                ]),
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0))),
          ),
        ),
      ),
      
      
      body:
       ListView.builder(
          itemCount: topicdata.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
                color: Color(0xff17181c),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Card(
                        color: Color(0xff040706),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(children: [
                            Container(
                              width: 65.0,
                              height: 65.0,
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.purple,
                                  //foregroundColor: Colors.purple,

                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.black,
                                    backgroundImage: AssetImage(
                                        'assets/images/gurujilogo.png'),
                                  )
                                  ),
                            ),
                            Container(
                                 width: 175,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Text(
                                  topicdata[index]["video_name"],
                                  // topic.name,
                                    maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: mediumTextStyle(),
                                ))
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: new GestureDetector(
                          onTap: () {
                            videoCode = calcultevideoCode(
                                topicdata[index]["video_link"]);
                            print(videoCode);
                            print(topicdata[index]["video_link"]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      YouTubeVideoPlayerScreen(
                                    videoname: videoCode,
                                  ),
                                ));
                          },
                          child: Card(
                              color: Color(0xff040706),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                height: 65,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                ),
                              )),
                        ))
                  ],
                ),
              )),

      
    );
  }

  

  calcultevideoCode(var videoLink) {
    var parts = videoLink.split('/');
    var videoCode = parts[3].trim();
    return videoCode;
  }
}

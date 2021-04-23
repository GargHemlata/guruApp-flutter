import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoPlayerScreen extends StatefulWidget {
  final String videoname;
  static String videoCodeId;

  const YouTubeVideoPlayerScreen({
    Key key,
    this.videoname,
  }) : super(key: key);

  @override
  _YouTubeVideoPlayerScreenState createState() =>
      _YouTubeVideoPlayerScreenState();
}

class _YouTubeVideoPlayerScreenState extends State<YouTubeVideoPlayerScreen> {
 
  YoutubePlayerController _controller;

 @override
  void initState() {

    _controller = YoutubePlayerController(
        initialVideoId: widget.videoname,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var newcode = widget.videoname;
    
    // YoutubePlayerController(
    //     initialVideoId: newcode,
    //     flags: YoutubePlayerFlags(
    //       autoPlay: true,
    //       mute: false,
    //     ));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: new GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(children: [
              new Image.asset("assets/images/back.png",
                  fit: BoxFit.cover,
                  height: 20.00,
                  color: Colors.grey,
                  width: 20.00),
            ]),
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('you have pushed the button this many times:',),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          )
        ],
      )),
    );
  }
}

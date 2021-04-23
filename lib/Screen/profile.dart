import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guruapp/Screen/loginScreen.dart';
import 'package:guruapp/widgets/widget.dart';
import 'package:guruapp/Screen/termsScreen.dart';
import 'package:guruapp/Screen/privacyScreen.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isOpen = true;
  var isLoading = false;
  // ignore: unused_field
  bool _autoValidate = false;

  _sendingMails() async {
    const url = 'mailto:hemlatagarg029@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingPhoneCall() async {
    const url = 'tel:8360569138';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getLogoutApi() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String accessToken = prefs.getString('access');
    print(accessToken);

    var response = await http.get(
        Uri.parse(
            'http://13.127.250.21/insight/tutorials/public/api/auth/logout'),
        headers: {
          "Accept": "application/json",
          "cache-control": "no-cache",
          "Authorization": "Bearer " + accessToken,
        });
    print(response);
    setState(() {
      isLoading = false;
    });

    int statusCode = response.statusCode;
    print(statusCode);

    if (statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      var token = prefs.remove('access');
      print(token);
    } else {
      Fluttertoast.showToast(
          msg: "Oops! Try Again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17181c),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Profile",
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            //Account
            Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Column(
                children: [
                  //1st
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: (isOpen
                            ? BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0),
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0),
                              )
                            : BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0),
                              )),
                        color: Colors.black),
                    child: Row(
                      children: [
                        Container(
                          width: 55.0,
                          height: 65.0,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                "Account",
                                style: mediumTextStyle(),
                              )),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                            },
                            child: Container(
                              color: Colors.black,
                              margin: EdgeInsets.only(right: 3.5),
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width,
                              child: IconButton(
                                splashColor: Colors.transparent,
                                icon: (isOpen
                                    ? Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      )),
                                onPressed: () {
                                  setState(() {
                                    isOpen = !isOpen;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //2nd
                  !isOpen
                      ? Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          color: Colors.black,
                          child: Container(
                            color: Colors.black,
                            child: Column(children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                autofocus: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter Name',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: Color(0xff17181c),
                                    filled: true,
                                    suffixIcon: Image.asset(
                                      'assets/images/name.png',
                                      color: Colors.grey,
                                    )),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: Color(0xff17181c),
                                    filled: true,
                                    suffixIcon: Image.asset(
                                      'assets/images/email.png',
                                      color: Colors.grey,
                                    )),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: false,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Enter PhoneNumber',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: Color(0xff17181c),
                                    filled: true,
                                    suffixIcon: Image.asset(
                                      'assets/images/phone.png',
                                      color: Colors.grey,
                                    )),
                              ),
                            ]),
                          ),
                        )
                      : Text(" "),
                ],
              ),
            ),

            //Rate us on Play Store
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new GestureDetector(
                onTap: () {
                  show();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Row(
                    children: [
                      Container(
                        width: 55.0,
                        height: 65.0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            "Rate Us On Play Store",
                            style: mediumTextStyle(),
                          )),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //show();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //privacy policy
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Row(
                    children: [
                      Container(
                        width: 55.0,
                        height: 65.0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.privacy_tip),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            "Privacy Policy",
                            style: mediumTextStyle(),
                          )),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyScreen()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //Terms& Condition
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Row(
                    children: [
                      Container(
                        width: 55.0,
                        height: 65.0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.notes),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            "Terms & Condition",
                            style: mediumTextStyle(),
                          )),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsScreen()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //Contact Us
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new GestureDetector(
                onTap: () {
                  _makingPhoneCall();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Row(
                    children: [
                      Container(
                        width: 55.0,
                        height: 65.0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.phone),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            "Contact Us",
                            style: mediumTextStyle(),
                          )),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //  _makingPhoneCall();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //Feedback
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new GestureDetector(
                onTap: () {
                  _sendingMails();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Row(
                    children: [
                      Container(
                        width: 55.0,
                        height: 65.0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.feedback),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            "Feedback",
                            style: mediumTextStyle(),
                          )),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // _sendingMails();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //LogOut
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new GestureDetector(
                onTap: () {
                  _getLogoutApi();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  // color: Colors.black,
                  child: Row(
                    children: [
                      Container(
                        width: 55.0,
                        height: 65.0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.logout),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            "LogOut",
                            style: mediumTextStyle(),
                          )),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // _getLogoutApi();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  getStringValuesSF() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String accesstoken = prefs.getString('access_token');
    print(accesstoken);

    var response = await http.post(
        Uri.parse(
            'http://13.127.250.21/insight/tutorials-dev/api/auth/verify-otp'),
        headers: {
          "Accept": "application/json",
          "cache-control": "no-cache",
          "Authorization": "Bearer " + accesstoken,
        });
    print(response);
    setState(() {
      isLoading = false;
    });

    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);

    if (statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      print('Not true Validate');
      setState(() {
        isLoading = false;
      });
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.star,
              size: 100,
              color: Colors.blue,
            ), // set your own image/icon widget
            title: "Flutter Rating Dialog",
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear 😍", // optional
            negativeComment: "We're sad to hear 😭", // optional
            accentColor: Colors.blue, // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
            },
          );
        });
  }
}

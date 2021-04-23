import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset('assets/images/logo.png', height: 50),
  );
}

InputDecoration textPhoneInputDecoration(String hintText){
       return InputDecoration(
            hintText: hintText,
                              hintStyle: TextStyle(color: Colors.grey),
                              // focusedBorder: InputBorder.none,
                              // errorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.black,
                                filled: true,
                                suffixIcon: Image.asset(
                  'assets/images/phone.png',
                                  color:Colors.grey,
                                ) );
}

InputDecoration textPasswordInputDecoration(String hintText){
       return InputDecoration(
            hintText: hintText,
                              hintStyle: TextStyle(color: Colors.grey),
                              // focusedBorder: InputBorder.none,
                              // errorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.black,
                                filled: true,
                                suffixIcon: Image.asset(
                  'assets/images/password.png',
                                  color:Colors.grey,
                                ) );
}



TextStyle simpleTextStyle(){
   return TextStyle(
     color: Colors.blue,
     fontSize: 14,
   );
}

TextStyle mediumTextStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontFamily: 'AdventPro',
  );
}
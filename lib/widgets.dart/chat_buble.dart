import 'package:firebase_login/costants.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: EdgeInsets.only(left: 16,top: 16,bottom:16 ,right: 16),
        //alignment: Alignment.centerLeft,
        child: Center(child: Text('i am a new user ',
          style: TextStyle(color: Colors.white),),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)
          ),
          color:kPrimaryColor,
        ),
      ),
    );
  }
}

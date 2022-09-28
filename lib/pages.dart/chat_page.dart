
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/costants.dart';
import 'package:firebase_login/widgets.dart/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String messages;
  User({required this.messages});

  factory User.fromMap(map){
    return User(
      messages: map['messages'],
    );
  }
}

class ChatPage extends StatelessWidget {
static String id ='ChatPage';
CollectionReference messages = FirebaseFirestore.instance.collection(kMessageCollections);
 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: messages.doc('6cQjXbgnwQ58zwCNfMLr').get(),
        builder: (context,snapchot){
          if (snapchot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(91, 74, 127, 10),

                    ),
                  ),
                ],
              ),
            );
          }
       // print(User.fromMap(snapchot.data?.data()).messages);
        print(snapchot.data?.data());
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor ,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/scholar.png',height: 50,),
              Text('chat')
            ],
          ),
          centerTitle:true,
        ),
        body:Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context,index){
                return ChatBuble();
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller:controller ,
                onSubmitted: (data){
                  messages.add(({
                    'message':data,

                  }));
                  controller.clear();
                },
                decoration: InputDecoration(
                  hintText: 'send meesage',
                  suffixIcon: Icon(Icons.send,color: kPrimaryColor,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.52),
                      borderSide:BorderSide(
                        color: kPrimaryColor,
                      )
                  ),

                ),
              ),
            ),
            IconButton(onPressed: ()async{
              await FirebaseFirestore.instance.collection('test').doc('ffff').set(
                  {'data':'ffff'});
            }, icon: Icon(Icons.add))
          ],
        ),
      );
    });
  }
}


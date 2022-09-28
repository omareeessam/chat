import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/costants.dart';
import 'package:firebase_login/pages.dart/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/costants.dart';
import 'package:firebase_login/pages.dart/register_page.dart';
import 'package:firebase_login/widgets.dart/custom_button.dart';
import 'package:firebase_login/widgets.dart/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_par.dart';

class LoginPage extends StatefulWidget {
 static String id ='Login Page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  GlobalKey<FormState>formKey = GlobalKey();
String? email,passward;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Image.asset('assets/images/scholar.png', height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              CustomFormTextField(
                onChanged: (data){
                  email =data;
                },
                hintText: 'Email',
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormTextField(
                onChanged: (data){
                  passward =data;
                },
                hintText: 'Passward',
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: 'Login',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
print(email);
print(passward);
                    try {
                     // await loginUser();
                      UserCredential userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: email!, password:passward!);
                      print(userCredential);
                      Navigator.pushNamed(context, ChatPage.id);
                    } on FirebaseAuth catch (ex) {
                      if (ex == 'user-not-found') {
                        showSnackPar(context, 'user-not-found');
                      } else if (ex == 'Wrong password provided for that user.') {
                        showSnackPar(context, 'Wrong password');
                      }
                    } catch (ex) {
                      print(ex);
                      showSnackPar(context, 'there was an error');
                    }
                    isLoading = false;
                    setState(() {});
                    showSnackPar(context, 'success');
                  } else {}
                },

              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dont\'t have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        '   Register',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email!, password:passward!);
  }
}
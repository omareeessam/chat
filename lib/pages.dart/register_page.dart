import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/pages.dart/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/costants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets.dart/custom_button.dart';
import '../widgets.dart/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'rigsterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formkey,
          child: ListView(
            children: [
              Image.asset('assets/images/scholar.png'),
              Text(
                'Scholar Chat',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    'Register',
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
                onChanged: (data) {
                  email = data;
                },
                hintText: 'Email',
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormTextField(
                onChanged: (data) {
                  password = data;
                },
                hintText: 'Passward',
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});

                    try {
                      await registerUser();
                      Navigator.pushNamed(context, ChatPage.id);

                    } on FirebaseAuth catch (ex) {
                      if (ex == 'weak-password') {
                        showSnackPar(context, 'weak passward');
                      } else if (ex == 'email-already-in-use') {
                        showSnackPar(context, 'email already exisits');
                      }
                    } catch (ex) {
                      showSnackPar(context, 'there was an error');
                    }
                    isLoading = false;
                    setState(() {});
                    showSnackPar(context, 'success');
                  } else {}
                },
                text: 'Register',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '   Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackPar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email:email!, password:password!);
  }
}

import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
CustomFormTextField({this.hintText,this.onChanged});
  String? hintText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      onChanged:onChanged ,
            decoration: InputDecoration(
            hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
                 border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                )
              )
            ),
          );
  }
}
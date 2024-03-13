import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key,this.decoration,required this.controller,required this.validator,this.MaxLines=1,this.MinLines=1});
  InputDecoration? decoration;
   TextEditingController? controller;
   String? Function(String?)? validator;
   int MaxLines;
   int MinLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: MaxLines,
      minLines: MinLines,
      decoration: decoration,
      controller: controller,
      validator: validator,
    );
  }
}

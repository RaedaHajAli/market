

import 'package:flutter/material.dart';


Widget CustomTextField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  String? label,
  String? hint,
  IconData? prefix,
  IconData? suffixIcon,
  Function()? suffixPressed,
  void Function(String?)? onSaved,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  bool obscureText = false,
  int? maxLines = 1

}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    onSaved:onSaved ,
    onChanged:onChanged ,
    onFieldSubmitted:onFieldSubmitted ,
    
    obscureText: obscureText,
    maxLines: maxLines,
  
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Field is required';
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
   
        labelText: label,
        hintText: hint,
        
        prefixIcon: Icon(prefix),
        suffixIcon: suffixIcon != null
            ? 
            IconButton(onPressed: suffixPressed, icon:
             Icon(suffixIcon,
           
          )
            )
            : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16)
            ),
           
           
            ),
  );
}

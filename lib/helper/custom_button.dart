import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({this.onTap, required this.text,this.color});
  final String? text;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color:color?? Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text('$text'.toUpperCase(),
            style:const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

buildGridView(
  BuildContext context,
  List list,
  Widget Function(int) generator,
) {
  return Container(
      color: Colors.grey[100],
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1 / 1.5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(list.length, generator),
      ));
}

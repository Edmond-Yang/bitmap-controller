import 'package:flutter/material.dart';

class CirclePreviewer extends StatelessWidget {

  double size;
  late Color color;

  CirclePreviewer({super.key, required this.size, required bool isLight}){
    color = isLight? Colors.pink: Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color
      ),
    );
  }
}

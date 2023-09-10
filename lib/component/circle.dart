import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleComponent extends StatelessWidget {

  int r, c;
  double size;
  late CircleInfo info;

  CircleComponent({super.key, required this.r, required this.c, required this.size, required bool isLight}){
    info = CircleInfo(row: r, column: c, isLight: isLight);
  }

  bool getValue() => info.isLight;

  void clearValue(){
    info.changeValue(false);
  }

  @override
  Widget build(BuildContext context) {

    double d = c == 7 ? 0.0 : 11.5;

    return ChangeNotifierProvider(
        create: (context) => info,
        child: Consumer<CircleInfo>(
          builder: (context, info , child) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  info.changeValue(null);
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: info.getColor()
                  ),
                ),
              ),
            );
          }
        )
    );
  }
}

class CircleInfo extends ChangeNotifier{

  int row, column;
  bool isLight;
  late Color color;

  CircleInfo({required this.row, required this.column, required this.isLight}){
    color = isLight? Colors.pink: Colors.grey[300]!;
  }

  void changeValue(bool? b){
    isLight = b ?? !isLight;
    color = isLight? Colors.pink: Colors.grey[300]!;
    notifyListeners();
  }

  Color getColor() => color;

}

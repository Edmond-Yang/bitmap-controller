import 'package:flutter/material.dart';
import '../component/previewCircle.dart';

class CirclePreview extends StatelessWidget {

  int n = 0;
  int delta = 1;
  List details;
  String mode;

  CirclePreview({super.key, required this.details, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: StatefulBuilder(
        builder: (context, setState){

          final width = MediaQuery.of(context).size.width;
          final w = MediaQuery.of(context).size.width*0.075;

          if(mode == '循環播放') {
            Future.delayed(const Duration(milliseconds: 500),(){
              setState((){
                  n = n >= details.length-1 ? 0 : n+1;
              });
            });
          }else{
            Future.delayed(const Duration(milliseconds: 500),(){
              setState((){

                if(n >= details.length-1){
                  delta = -1;
                }
                else if( n <= 0){
                  delta = 1;
                }
                n = n+delta;

              });
            });
          }
          print(details[n]);

          return Container(
            margin: EdgeInsets.symmetric(horizontal: width*0.092),
            child: Column(
              children: [
                const SizedBox(height: 50),
                for(var i = 0; i < 8; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for(var j = 0; j < 8; j++)
                        CirclePreviewer(size: w, isLight: details[n]['detail'][i*8+j])
                    ],
                  )

              ],
            ),
          );
        },
      )
    );
  }
}


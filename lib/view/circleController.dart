import 'package:flutter/material.dart';
import '../component/circle.dart';

class CircleController extends StatelessWidget {

  String text;
  List boolData;
  List<CircleComponent> allData = [];

  CircleController({super.key,required this.boolData,required this.text});

  List<bool> getValue(){
    List<bool> res = [];

    for(var i in allData) {
      res.add(i.getValue());
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double w =  width * 0.075;

    List<Widget> data = [];
    List<CircleComponent> rowdata = [];

    for(var i=0 ; i<8; i++){
      rowdata = [];
      for(var j=0; j<8 ; j++){
        CircleComponent temp = CircleComponent(r: i, c: j, size: w, isLight: boolData[i*8+j],);
        rowdata.add(temp);
        allData.add(temp);
      }
      data.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.from(rowdata),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('BitMap'),
          actions: [
            ElevatedButton(
                onPressed: (){
                  for(var btn in allData){
                    btn.clearValue();
                    print('r: ${btn.r}, c: ${btn.c}, isLight: ${btn.getValue()}');
                  }},
                style: ElevatedButton.styleFrom(
                  elevation: 0.0
                ),
                child: const Row(
                  children: [
                    Icon(Icons.clear),
                    SizedBox(width: 10,),
                    Text('清空')
              ],

            )),
            ElevatedButton(
                onPressed: (){
                    Navigator.pop(context, {'status': 'delete', 'text': text});
                  },
                style: ElevatedButton.styleFrom(
                    elevation: 0.0
                ),
                child: const Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 10,),
                    Text('刪除')
                  ],

                )),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: width*0.092),
          child: Column(
            children: <Widget>[
              SizedBox(height: height* 0.13),
              Center(child: Text(text, style: const TextStyle(
                  fontSize: 25
              ),)),
              const SizedBox(height: 50.0),
            ] + data + [
              const SizedBox(height: 60),
              TextButton(onPressed: (){
                  Navigator.pop(context, {'status': 'modify', 'text': text, 'detail': getValue()});
              }, style: TextButton.styleFrom(
                  fixedSize: const Size(100, 50)
              ), child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 10),
                  Text('確認', style: TextStyle(
                      fontSize: 20
                  ),)
                ],
              ),
              )
            ],
          ),
        )
    );
  }
}
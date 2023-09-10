import 'package:flutter/material.dart';
import './circleController.dart';
import 'circlePreview.dart';
import '../service/bitmapData.dart';
import './loading.dart';

class GroupBitmap extends StatefulWidget {
  const GroupBitmap({Key? key}) : super(key: key);

  @override
  State<GroupBitmap> createState() => _GroupBitmapState();
}

class _GroupBitmapState extends State<GroupBitmap> {

  late Bitmap data = Bitmap();


  @override
  Widget build(BuildContext context) {



    if(data.status == 0) {
      data.setData().then((value){
        setState(() {

        });
      });
      return const Loading();
    }

    // return Loading()

    return Scaffold(
        appBar: AppBar(
          title: const Text('Animate'),
          actions: [
            ElevatedButton(
                onPressed: (){
                  if(data.data.isNotEmpty){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CirclePreview(details: data.data, mode: data.mode),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0.0
                ),
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text('預覽')
                  ],
                )),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    data.clearData();
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0
                ),
                child: const Row(
                  children: [
                    Icon(Icons.clear),
                    Text('清空')
                  ],
                )),
            ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context){
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              height: 250,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0)
                                ),
                                color: Colors.white
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed:(){
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          shape: const CircleBorder(),
                                          iconColor: Colors.black,
                                          foregroundColor: Colors.grey
                                        ),
                                        child: const Icon(Icons.clear),
                                      ),
                                      const SizedBox(width: 20)
                                    ],
                                  ),
                                  const Center(
                                    child: Text('播放設定', style: TextStyle(
                                      fontSize: 20
                                    ),)
                                  ),
                                  const SizedBox(height: 15),
                                  Center(
                                    child: RadioListTile<String>(
                                      title: const Text('循環播放'),
                                      value: '循環播放',
                                      groupValue: data.mode,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          data.mode = newValue!;
                                        });
                                        },
                                    ),
                                  ),
                                  Center(
                                    child: RadioListTile<String>(
                                      title: const Text('來回播放'),
                                      value: '來回播放',
                                      groupValue: data.mode,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          data.mode = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            );
                          }
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0.0
                ),
                child: const Row(
                  children: [
                    Icon(Icons.settings),
                    Text('播放')
                  ],
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: ReorderableListView(
                        children: [
                          for(var t in data.data)
                            ListTile(
                              key: ValueKey(t['text']),
                              title: Text(t['text']),
                              onTap: ()async{
                                dynamic d = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CircleController(boolData: t['detail'], text: t['text'])),
                                );

                                for(var tile=0 ; tile < data.data.length ; tile++){
                                  if(data.data[tile]['text'] == d['text']){
                                    if(d['status'] == 'delete'){
                                      setState(() {
                                        data.data.removeAt(tile);
                                      });
                                    }else{
                                      setState(() {
                                        data.data[tile]['detail'] = d['detail'];
                                      });
                                    }
                                    break;
                                  }
                                }
                              },
                            )
                        ],
                        onReorder: (oldIndex, newIndex){
                          if(oldIndex < newIndex){
                            newIndex--;
                          }

                          setState(() {
                            final img = data.data.removeAt(oldIndex);
                            data.data.insert(newIndex, img);
                          });
                        }),
            ),
            ElevatedButton(
                onPressed: ()async{
                  // TODO: update to web
                  await data.sendData();
                  const snackBar = SnackBar(
                    content: Text('上傳成功'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    fixedSize: const Size(90, 10)
                ),
                child: const Row(
                  children: [
                    Icon(Icons.upload),
                    Text('儲存')
                  ],
                )),
            const SizedBox(height: 30)
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            data.addData();
          });
        },
        child: const Icon(
          Icons.add
        ),
      ),
    );
  }
}

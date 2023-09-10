import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

class WebData{

    Future<Map> getData()async {

      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://embeddedsystem-edmondyang.onrender.com/appData"));
      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();
      Map data = jsonDecode(reply);
      print(data);

      return {'playMode': data['mode'], 'result': data['animate']};

    }

    Future<void> upload(String mode, List res)async{


        HttpClient httpClient = HttpClient();
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

        HttpClientRequest request = await httpClient.postUrl(Uri.parse("https://embeddedsystem-edmondyang.onrender.com/upload"));
        request.headers.set('content-type', 'application/json');
        request.add(utf8.encode(json.encode({"mode": mode, "animate": res})));
        HttpClientResponse response = await request.close();

        String reply = await response.transform(utf8.decoder).join();
        Map data = jsonDecode(reply);
        print(data['status']);


    }
}

class Bitmap{

  int status = 0;
  WebData api = WebData();
  late List data;
  late String mode;
  late int len;

  Future<void> setData()async {
    final d = await api.getData();
    data = d['result'];
    mode = d['playMode'];
    len = data.length;
    status = 200;
  }

  void addData(){
    List t=[];
    len++;
    int l = data.length;
    for(var i=0; i<64; i++){
      if(l == 0) {
        t.add(false);
      } else {
        t.add(data.last['detail'][i]);
      }
    }
    print('圖案$len');
    data.add({'text': '圖案$len', 'detail': t});

  }

  Future<void> sendData()async{
    await api.upload(mode, data);
  }

  void clearData(){
    data=[];
    len = 0;
  }

}
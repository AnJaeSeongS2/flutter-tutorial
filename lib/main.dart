import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('T.G.WinG Member Jaeseong'),
        ),
        body: Center(child: Image(image: NetworkImage("http://tgwing.kr/images/logo.png"))),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:hello_world/data/JoinOrLogin.dart';
import 'package:hello_world/screens/AuthPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 다른 파일로부터 AuthPage 에게 state전달이 가능한 지 확인하기위해 여기서 JoinOrJoin 의 providervalue로 wrapping한다. 더 나은 것은 AuthPage내부에서 원하는 Widget사이에서이다.
      home: ChangeNotifierProvider<JoinOrLogin>.value(
        value: JoinOrLogin(),
        child: AuthPage(),
      ),
    );
  }
}

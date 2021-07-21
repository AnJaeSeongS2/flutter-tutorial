import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/data/JoinOrLogin.dart';
import 'package:hello_world/screens/AuthPage.dart';
import 'package:hello_world/screens/Loading.dart';
import 'package:hello_world/screens/MainPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("something went wrong.");
          // return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return RealApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();
        return MaterialApp(
          home: Loading(),
        );
      },
    );
  }

  Widget RealApp() => MaterialApp(
        // 다른 파일로부터 AuthPage 에게 state전달이 가능한 지 확인하기위해 여기서 JoinOrJoin 의 providervalue로 wrapping한다. 더 나은 것은 AuthPage내부에서 원하는 Widget사이에서이다.
        home: Splash(),
      );
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return ChangeNotifierProvider<JoinOrLogin>.value(
            value: JoinOrLogin(),
            child: AuthPage(),
          );
        } else {
          return MainPage(email: snapshot.data!.email);
        }
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/data/JoinOrLogin.dart';
import 'package:hello_world/helper/AuthPageBackground.dart';
import 'package:hello_world/screens/ForgetPassword.dart';
import 'package:provider/provider.dart';

import 'MainPage.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: size,
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _logoImage(),
              Stack(
                children: [
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child) => GestureDetector(
                  onTap: () {
                    Provider.of<JoinOrLogin>(context, listen: false).toggle();
                  },
                  child: Text(
                    joinOrLogin.isJoin
                        ? "Already Have an Account? Sign in."
                        : "Don't Have an Account? Create One.",
                    style: TextStyle(
                      color: joinOrLogin.isJoin ? Colors.red : Colors.blue,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputForm(Size size) => Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: 32,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: "Email",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please input correct Email.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "Password",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please input correct password.";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 8,
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, value, child) => Opacity(
                      opacity: value.isJoin ? 0 : 1,
                      child: GestureDetector(
                        onTap: value.isJoin ? null : () => _goToForgetPassword(context),
                        child: Text("Forgot Password?"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  _goToForgetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgetPassword(),
      ),
    );
  }

  Widget _authButton(Size size) => Positioned(
        left: size.width * 0.15,
        right: size.width * 0.15,
        bottom: 0,
        child: SizedBox(
          height: 40,
          child: Consumer<JoinOrLogin>(
              builder: (context, joinOrLogin, child) => RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: joinOrLogin.isJoin ? Colors.red : Colors.blue,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        joinOrLogin.isJoin
                            ? _registerAccount(context)
                            : _login(context);
                      }
                    },
                    child: Text(
                      joinOrLogin.isJoin ? "Join" : "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),
        ),
      );

  Widget _logoImage() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/login.gif"),
              // image: "http://tgwing.kr/images/logo.png"),
            ),
          ),
        ),
      );

  void _registerAccount(BuildContext context) async {
    // TODO: invalid Format Throw catch
    final UserCredential newUserCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User? newUser = newUserCredential.user;

    if (newUser == null) {
      final snackBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(email: newUser!.email),));
  }

  void _login(BuildContext context) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User? user = userCredential.user;

    if (user == null) {
      final snackBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(email: user!.email),));
  }
}

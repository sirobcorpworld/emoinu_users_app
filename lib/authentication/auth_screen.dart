import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';



class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration:   BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal[800]!,
                  Colors.teal[900]!,
                ],
                begin:  const FractionalOffset(0.0, 0.0),
                end:  const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
              "Emoinu",
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
              fontFamily: "Pacifico",
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white,),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.teal[600],
          ),
          child: const TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

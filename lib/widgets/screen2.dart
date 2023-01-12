import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;
  const Screen2(
      {Key? key,
       this.menuScreenContext,
        this.onScreenHideButtonPressed,
        this.hideStatus = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.indigo,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Test Text Field"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
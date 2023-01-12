import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget
{
  final String? title;
  final PreferredSizeWidget? bottom;

  SimpleAppBar({Key? key, this.bottom, this.title}) : super(key: key);

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xff263238),
        ),
      ),
      centerTitle: true,
      title: Text(
        title!,
        style: const TextStyle(fontSize: 40.0, letterSpacing: 3, color: Colors.white, fontFamily: "Pacifico"),
      ),
    );
  }
}

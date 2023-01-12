import 'package:flutter/material.dart';
import 'package:emoinu_users_app/mainScreens/items_screen.dart';
import 'package:emoinu_users_app/models/menus.dart';



class MenusDesignWidget extends StatefulWidget
{
  final Menus? model;
  final BuildContext? context;

  // ignore: use_key_in_widget_constructors
  const MenusDesignWidget({this.model, this.context});

  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}



class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.indigo.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.indigo.shade100,
          ),
          height: MediaQuery.of(context).size.height*0.2,
           width: MediaQuery.of(context).size.width*0.2,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl!,
                    // height: MediaQuery.of(context).size.height / 5,
                    // width: MediaQuery.of(context).size.width ,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.2, 0.7],
                      colors: [
                       Colors.black38,
                        Colors.black38,
                      ],
                      // stops: [0.0, 0.1],
                    ),
                  ),
                  // height: MediaQuery.of(context).size.height / 5,
                  // width: MediaQuery.of(context).size.width / 3,
                ),
                   Center(
                     child: Container(
                       // height: MediaQuery.of(context).size.height / 5,
                       //  width: MediaQuery.of(context).size.width / 3,
                       padding: const EdgeInsets.all(1),
                       constraints: const BoxConstraints(
                         minWidth: 20,
                         minHeight: 20,
                       ),
                       child: Center(
                         child: Text(
                           widget.model!.menuTitle!,
                           textAlign: TextAlign.center,
                           style:   const TextStyle(
                             color: Colors.white,
                             fontSize: 25,
                             fontWeight: FontWeight.bold,
                             fontFamily: "Proxima",
                             letterSpacing: 1.0,
                           ),
                         ),
                       ),

                    // Column(
                    //   children: [
                    //     Text(
                    //       widget.model!.menuTitle!,
                    //       textAlign: TextAlign.center,
                    //       style:   const TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 25,
                    //         fontFamily: "Proxima",
                    //         letterSpacing: 1.0,
                    //       ),
                    //     ),
                    //     Text(
                    //       widget.model!.menuInfo!,
                    //       textAlign: TextAlign.center,
                    //       style:  const TextStyle(
                    //         color: Colors.white54,
                    //         fontSize: 12.0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:emoinu_users_app/assistantMethods/cart_item_counter.dart';
import 'package:emoinu_users_app/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

 const colorizeColors = [
  Colors.white,
  Colors.greenAccent,
   Colors.amberAccent,
   Colors.black12,
   Colors.greenAccent,
];
class MyAppBar extends StatefulWidget with PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;

  MyAppBar({Key? key, this.bottom, this.sellerUID}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar>
{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
        ),
      ),
      title: AnimatedTextKit(
        isRepeatingAnimation: true,
        repeatForever: true,
        pause: const Duration(milliseconds:360 ),
        animatedTexts : [
          ColorizeAnimatedText(
            'Emoinu Foods',
            textStyle: const TextStyle(fontSize: 40, fontFamily: "Pacifico"),
            colors: colorizeColors,
          ),
        ],

      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: ()
        {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: true,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white,),
              onPressed: ()
              {
                //send user to cart screen
                Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID)));
              },
            ),
            Positioned(
              child: Stack(
                children: [
                  const Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 3,
                    right: 4,
                    child: Center(
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, c)
                        {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

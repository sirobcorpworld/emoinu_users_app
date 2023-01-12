import 'package:emoinu_users_app/mainScreens/menus_screen.dart';
import 'package:emoinu_users_app/mainScreens/search_screen.dart';
import 'package:emoinu_users_app/models/sellers.dart';
import 'package:emoinu_users_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:emoinu_users_app/assistantMethods/cart_item_counter.dart';
import 'package:emoinu_users_app/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const colorizeColors = [
  Colors.white,
  Colors.blueGrey,
  Colors.black54,
  Colors.blueGrey,
];
class MyTabBar extends StatefulWidget with PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  final Sellers? model;
  MyTabBar({Key? key, this.bottom, this.sellerUID, this.model}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();

  @override
  Size get preferredSize => bottom==null?Size(56, const TabBar(tabs: [],).preferredSize.height):Size(56, 80+const TabBar(tabs: [],).preferredSize.height);
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
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
        ),
        bottomNavigationBar: menu(),
        drawer: const MyDrawer(),
        body:  Container(
          decoration: BoxDecoration(
            color: Colors.teal[600],
          ),
          child: const TabBarView(
            children: [
              MenusScreen(),
              SearchScreen(),
              MenusScreen(),
              MenusScreen(),
            ],
          ),
        ),
      ),
    );
}
    Widget menu() {
    return SingleChildScrollView(
       child: Container(
      color: const Color(0xFF3F5AA6),
      child: const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
      Tab(
      text: "Home",
      icon: Icon(Icons.account_balance_rounded),
      ),
      Tab(
      text: "Bills",
      icon: Icon(Icons.assignment),
      ),
      Tab(
      text: "Balance",
      icon: Icon(Icons.account_balance_wallet),
      ),
      Tab(
      text: "Options",
      icon: Icon(Icons.settings),
      ),
      ],
      ),
      ),
    );

    }
  }


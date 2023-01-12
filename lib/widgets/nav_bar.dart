import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:emoinu_users_app/assistantMethods/cart_item_counter.dart';
import 'package:emoinu_users_app/mainScreens/main_screen.dart';
import 'package:emoinu_users_app/mainScreens/menus_screen.dart';
import 'package:emoinu_users_app/mainScreens/my_orders_screen.dart';
import 'package:emoinu_users_app/mainScreens/search_screen.dart';
import 'package:emoinu_users_app/models/sellers.dart';
import 'package:emoinu_users_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../mainScreens/cart_screen.dart';
import 'app_bar.dart';

class ProvidedStylesExample extends StatefulWidget {
  final Sellers? model;
  final BuildContext? menuScreenContext;
  const ProvidedStylesExample( {Key? key,  this.menuScreenContext,  this.model }) : super(key: key) ;

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  BuildContext? testContext;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      MainScreen(
        model: widget.model,
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MenusScreen(
       model: widget.model,
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      SearchScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MyOrdersScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: "menu",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add_call),
        title: ("Orders"),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID:  widget.model?.sellerUID,)));
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
      drawer: const MyDrawer(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.blueGrey.shade900,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "ARE YOU READY TO LEAVE ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),

                        height: 50.0,
                        width: 100.0,
                        child: ElevatedButton(
                          child: const Text("Back"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        height: 50.0,
                        width: 100.0,
                        child: ElevatedButton(
                          child: const Text("Close"),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
          return false;
        },
        selectedTabScreenContext: (context) {
          testContext = context;
        },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.white,
            borderRadius: BorderRadius.circular(20.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
        NavBarStyle.style1, // Choose the nav bar style with this property
      ),
    );
  }
}


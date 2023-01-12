import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:emoinu_users_app/assistantMethods/assistant_methods.dart';
import 'package:emoinu_users_app/assistantMethods/cart_item_counter.dart';
import 'package:emoinu_users_app/assistantMethods/total_amount.dart';
import 'package:emoinu_users_app/mainScreens/address_screen.dart';
import 'package:emoinu_users_app/models/items.dart';
import 'package:emoinu_users_app/widgets/cart_item_design.dart';
import 'package:emoinu_users_app/widgets/progress_bar.dart';
import 'package:emoinu_users_app/widgets/text_widget_header.dart';
import 'package:provider/provider.dart';

import '../models/menus.dart';
import '../widgets/app_bar.dart';


class CartScreen extends StatefulWidget
{
  final String? sellerUID;
  final Menus? model;
  const CartScreen({Key? key, this.sellerUID, this.model}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen>
{
  List<int>? separateItemQuantityList;
  num totalAmount = 0;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);

    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
             color: Colors.blueGrey[900],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
        title:AnimatedTextKit(
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
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: ()
                {
                  if (kDebugMode) {
                    print("clicked");
                  }
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 10,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text("Clear Cart", style: TextStyle(fontSize: 16),),
              backgroundColor: Colors.blueGrey[800],
              icon: const Icon(Icons.clear_all),
              onPressed: ()
              {
                clearCartNow(context);
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

                Fluttertoast.showToast(msg: "Cart has been cleared.");
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text("Check Out", style: TextStyle(fontSize: 16),),
              backgroundColor: Colors.blueGrey[800],
              icon: const Icon(Icons.navigate_next),
              onPressed: ()
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c)=> AddressScreen(
                          totalAmount: totalAmount.toDouble(),
                          sellerUID: widget.sellerUID,
                        ),
                    ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [

            //overall total amount
            SliverPersistentHeader(
                pinned: true,
                delegate: TextWidgetHeader(title: "My Cart List")
            ),

            SliverToBoxAdapter(
              child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
              {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total Price: " + amountProvider.tAmount.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight:  FontWeight.w500,
                              ),
                          ),
                  ),
                );
              }),
            ),

            //display cart items with quantity number
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("items")
                  .where("itemID", whereIn: separateItemIDs())
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot)
              {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                    : snapshot.data!.docs.isEmpty
                    ? //startBuildingCart()
                      SliverToBoxAdapter(child: Container())
                    : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index)
                      {
                        Items model = Items.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                        );

                        if(index == 0)
                        {
                          totalAmount = 0;
                          totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                        }
                        else
                        {
                          totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                        }

                        if(snapshot.data!.docs.length - 1 == index)
                        {
                          WidgetsBinding.instance!.addPostFrameCallback((timeStamp)
                          {
                            Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());
                          });
                        }

                        return CartItemDesign(
                          model: model,
                          context: context,
                          quanNumber: separateItemQuantityList![index],
                        );
                      },
                      childCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                    ),
                   );
              },
            ),
          ],
        ),
      ),
    );
  }
}

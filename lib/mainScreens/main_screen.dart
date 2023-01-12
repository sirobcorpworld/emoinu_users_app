import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../extra/categories.dart';
import '../extra/dishes.dart';
import '../extra/foods.dart';
import '../extra/grid_product.dart';
import '../extra/home_category.dart';
import '../extra/slider_item.dart';
import '../models/menus.dart';
import '../models/sellers.dart';
import '../widgets/menus_design.dart';
import '../widgets/progress_bar.dart';


class MainScreen extends StatefulWidget {
  final Sellers? model;
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool? hideStatus;
  const MainScreen({Key? key,
    this.menuScreenContext,
    this.onScreenHideButtonPressed,
    this.hideStatus, this.model}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin<MainScreen>{

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: SingleChildScrollView(
          child: Column(
                 mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Dishes",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  TextButton(
                    child: Text(
                      "View More",
                      style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return DishesScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10.0),

              //Slider Here

              CarouselSlider(

                items: map<Widget>(
                  foods,
                      (index, i){
                    Map food = foods[index];
                    return SliderItem(
                      img: food['img'],
                      isFav: true,
                      name: food['name'],
                      rating: 5.0,
                      raters: 23,
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                height: MediaQuery.of(context).size.height/2.4,
                viewportFraction: 1.0,
//              aspectRatio: 2.0,
                autoPlay: true,
//                enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
              ),
              ),
              const SizedBox(height: 20.0),

              const Text(
                "All Categories",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),

              Container(
                height: 200,
                width: double.infinity,
                // height: MediaQuery.of(context).size.height*0.2,
                // width: MediaQuery.of(context).size.width,
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  slivers: [
                    // SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: " All  Categories")),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("sellers")
                          .doc(widget.model?.sellerUID)
                          .collection("menus")
                          .orderBy("publishedDate", descending: true)
                          .snapshots(),
                      builder: (context, snapshot)
                      {
                        return !snapshot.hasData
                            ? SliverToBoxAdapter(
                          child: Center(child: circularProgress(),),
                        )
                            : SliverStaggeredGrid.countBuilder(
                          crossAxisCount: 1,
                          staggeredTileBuilder: (c) => const StaggeredTile.count(1,1),
                          itemBuilder: (context, index)
                          {
                            Menus model = Menus.fromJson(
                              snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                            );
                            return MenusDesignWidget(
                              model: model,
                              context: context,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      },
                    ),
                    // const SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     width: 150.0,
                    //   ),
                    // )
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Popular Items",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  TextButton(
                    child: Text(
                      "View More",
                      style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: (){},
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.25),
                ),
                itemCount: foods.isEmpty ? 0 :foods.length,
                itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                  Map food = foods[index];
//                print(foods);
//                print(foods.length);
                  return GridProduct(
                    img: food['img'],
                    isFav: false,
                    name: food['name'],
                    rating: 5.0,
                    raters: 23,
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoinu_users_app/widgets/app_bar.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:emoinu_users_app/models/menus.dart';
import 'package:emoinu_users_app/models/sellers.dart';
import 'package:emoinu_users_app/widgets/menus_design.dart';
import 'package:emoinu_users_app/widgets/progress_bar.dart';
import 'package:emoinu_users_app/widgets/text_widget_header.dart';
// import 'package:provider/provider.dart';

// import '../assistantMethods/cart_item_counter.dart';
// import '../widgets/my_drawer.dart';
// import 'cart_screen.dart';


class MenusScreen extends StatefulWidget
{
  final Sellers? model;
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool? hideStatus;
  const MenusScreen(
      {Key? key,
        this.model,
        this.menuScreenContext,
        this.onScreenHideButtonPressed,
        this.hideStatus
       }
     ) : super(key: key);

  @override
  _MenusScreenState createState() => _MenusScreenState();
}



class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            body: CustomScrollView(

              slivers: [
                SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: " All  Categories")),
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
                      crossAxisCount: 2,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
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
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 150.0,
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
    }
  }

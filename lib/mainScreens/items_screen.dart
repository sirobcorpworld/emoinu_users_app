import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:emoinu_users_app/models/items.dart';
import 'package:emoinu_users_app/models/menus.dart';
import 'package:emoinu_users_app/widgets/items_design.dart';
import 'package:emoinu_users_app/widgets/progress_bar.dart';
import 'package:emoinu_users_app/widgets/text_widget_header.dart';


class ItemsScreen extends StatefulWidget
{
  final Menus? model;
  const ItemsScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}



class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.menuTitle.toString()+" Items")),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection("menus")
                  .doc(widget.model!.menuID)
                  .collection("items")
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
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    Items model = Items.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return ItemsDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

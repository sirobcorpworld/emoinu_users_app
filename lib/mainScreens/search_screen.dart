import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoinu_users_app/widgets/items_design.dart';
import 'package:flutter/material.dart';

import '../models/items.dart';



class SearchScreen extends StatefulWidget
{  final BuildContext? menuScreenContext;
   final Function? onScreenHideButtonPressed;
   final bool? hideStatus;
  const SearchScreen({Key? key,
    this.menuScreenContext,
    this.onScreenHideButtonPressed,
    this.hideStatus}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}




class _SearchScreenState extends State<SearchScreen>
{
  Future<QuerySnapshot>? itemsDocumentsList;
  String itemNameText = "";

  initSearchingItem(String textEntered)
  {
   itemsDocumentsList = FirebaseFirestore.instance
        .collection("items")
        .where("title", isGreaterThanOrEqualTo: textEntered)
        .get();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                onChanged: (textEntered)
                {
                  setState(() {
                    itemNameText = textEntered;
                  });
                  //init search
                  initSearchingItem(textEntered);
                },
                decoration:  const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                  ),
                  hintText: 'Search Items here..',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder<QuerySnapshot>(
                future: itemsDocumentsList,
                builder: (context, snapshot)
                {
                  return snapshot.hasData
                      ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index)
                    {
                      Items model = Items.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String, dynamic>
                      );

                      return ItemsDesignWidget(
                        model: model,
                        context: context,
                      );
                    },
                  )
                      : const Center(child: Text("No Record Found"),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

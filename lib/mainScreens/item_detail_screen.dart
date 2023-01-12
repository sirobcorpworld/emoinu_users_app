import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:emoinu_users_app/assistantMethods/assistant_methods.dart';
import 'package:emoinu_users_app/models/items.dart';
import 'package:number_inc_dec/number_inc_dec.dart';


class ItemDetailsScreen extends StatefulWidget
{
  final Items? model;
  const ItemDetailsScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}




class _ItemDetailsScreenState extends State<ItemDetailsScreen>
{  bool isFav = false;
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: const EdgeInsets.all(15.0),
         children: [
           Stack(
             children: [

               Container(
                 height: MediaQuery.of(context).size.height / 3.2,
                 width: MediaQuery.of(context).size.width,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                     child: Image.network(
                         widget.model!.thumbnailUrl.toString(),
                         fit: BoxFit.cover,
                     ),
                 ),
               ),
               Positioned(
                 left: 10,
                 bottom: 10,
                 child: Text(
                   ' ${widget.model!.title.toString()}',
                   style:  const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize:24,
                     fontFamily: "Poppins",
                     color: Colors.white,
                     backgroundColor: Colors.black54,
                   ),
                 ),
               ),
               Positioned(
                 right: -10.0,
                 bottom: 3.0,
                 child: RawMaterialButton(
                   onPressed: (){},
                   fillColor: Colors.white,
                   shape: const CircleBorder(),
                   elevation: 4.0,
                   child: Padding(
                     padding: const EdgeInsets.all(5),
                     child: Icon(
                       isFav
                           ?Icons.favorite
                           :Icons.favorite_border,
                       color: Colors.red,
                       size: 20,
                     ),
                   ),
                 ),
               ),
             ],
           ),
           const SizedBox(height: 20.0),
           Row(
             children: [
               Text(
                 'Stock : ${widget.model!.status.toString()}',
                 textAlign: TextAlign.left,
                 style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: Colors.black,),
               ),
               const SizedBox(width: 50.0),
               Text(
                 'Price : ₹ ${widget.model!.price.toString()}',
                 textAlign: TextAlign.right,
                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blue,),
               ),
             ],
           ),
           const SizedBox(height: 20.0),
           const Text(
             "Product Description",
             textAlign: TextAlign.left,
             style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.w800,
             ),
             maxLines: 2,
           ),
           const SizedBox(height: 10.0),
           Container(
             height: MediaQuery.of(context).size.height/6,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   ' ${widget.model!.shortInfo.toString()}',
                   textAlign: TextAlign.left,
                   style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18,color: Colors.black54,),
                 ),
                 Text(
                   ' ${widget.model!.longDescription.toString()}',
                   textAlign: TextAlign.left,
                   style: const TextStyle(
                     fontWeight: FontWeight.normal,
                     fontSize: 18,
                     color: Colors.black54,
                   ),
                 ),
               ],
             ),
           ),

               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: NumberInputPrefabbed.roundedButtons(
                   controller: counterTextEditingController,
                   numberFieldDecoration: const InputDecoration(
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.green, width: 2.0),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.green, width: 2.0),
                     ),
                   ),
                   incDecBgColor: Colors.white,
                   min: 1,
                   max: 9,
                   initialValue: 1,
                   buttonArrangement: ButtonArrangement.incRightDecLeft,
                 ),
               ),
           const SizedBox(height: 10.0),
                InkWell(
               onTap: ()
               {
                 int itemCounter = int.parse(counterTextEditingController.text);

                 List<String> separateItemIDsList = separateItemIDs();

                 //1.check if item exist already in cart
                 separateItemIDsList.contains(widget.model!.itemID)
                     ? Fluttertoast.showToast(msg: "Item is already in Cart.")
                     :
                 //2.add to cart
                 addItemToCart(widget.model!.itemID, context, itemCounter);
               },
               child: Container(
                 height: 50.0,
                 decoration:  BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                    color: Colors.cyan,
                 ),
                 width: MediaQuery.of(context).size.width - 13,
                 child:  const Center(
                   child: Text(
                     "Add to Cart",
                     style: TextStyle(color: Colors.white, fontSize: 25,fontWeight:FontWeight.w900),
                   ),
                 ),
               ),
                ),

         ],
      ),
    );
  }
}

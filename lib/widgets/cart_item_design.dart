import 'package:flutter/material.dart';
import 'package:emoinu_users_app/models/items.dart';


class CartItemDesign extends StatefulWidget
{
  final Items? model;
  final BuildContext? context;
  final int? quanNumber;

  const CartItemDesign({Key? key,
    this.model,
    this.context,
    this.quanNumber,
  }) : super(key: key);

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.indigo.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.indigo.shade100,
          ),
          height: MediaQuery.of(context).size.width*0.33,
          width: MediaQuery.of(context).size.width*0.8,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [

                //image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.model!.thumbnailUrl!,
                      width: 140,
                      height: 120,
                    ),
                ),

                const SizedBox(width: 6,),

                //title
                //quantity number
                //price
                Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blueGrey.shade600,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      Expanded(
                        child: Text(
                          'Item : ${widget.model!.title!}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.model!.longDescription!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13.0,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      //quantity number // x 7
                      Expanded(
                        child: Text(
                          'Quantity : ${widget.quanNumber.toString()}',
                          style:  const TextStyle(
                            color: Colors.white70,
                            fontSize: 13.0,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      //price
                      Expanded(
                        child: Row(
                          children: [
                                 const Text(
                              "Price: ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                             const Text(
                              "₹ ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                              ),
                            ),
                            Text(
                                widget.model!.price.toString(),
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

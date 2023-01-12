import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:emoinu_users_app/models/items.dart';


class OrderCard extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  const OrderCard({Key? key,
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        //todo
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.indigo.shade100,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: itemCount! * 105,
        child: ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index)
          {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}




Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
{
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.blueGrey.shade500,
    ),
    margin: const EdgeInsets.only(top: 5.0),
    width: MediaQuery.of(context).size.width,
    height: 90.0,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                model.thumbnailUrl!,
                height: 100.0,
                width: 100.0,),
          ),
          const SizedBox(width: 20.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        seperateQuantitiesList,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "Poppins",
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "₹ ",
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    ),
  );
}

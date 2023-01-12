import 'package:flutter/material.dart';

import 'foods.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "${foods[1]['img']}",
                      fit: BoxFit.cover,
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
                        size: 17,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Text(
                    "${foods[1]['name']}",
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  const Text(
                    "20 Pieces",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  Text(
                    r"Price : $90",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),

                ],
              ),
            ),


            const SizedBox(height: 20.0),

            const Text(
              "Product Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 10.0),

            const Text(
              "Nulla quis lorem ut libero malesuada feugiat. Lorem ipsum dolor "
                  "sit amet, consectetur adipiscing elit. Curabitur aliquet quam "
                  "id dui posuere blandit. Pellentesque in ipsum id orci porta "
                  "dapibus. Vestibulum ante ipsum primis in faucibus orci luctus "
                  "et ultrices posuere cubilia Curae; Donec velit neque, auctor "
                  "sit amet aliquam vel, ullamcorper sit amet ligula. Donec"
                  " rutrum congue leo eget malesuada. Vivamus magna justo,"
                  " lacinia eget consectetur sed, convallis at tellus."
                  " Vivamus suscipit tortor eget felis porttitor volutpat."
                  " Donec rutrum congue leo eget malesuada."
                  " Pellentesque in ipsum id orci porta dapibus.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),

            const SizedBox(height: 20.0),

            const Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20.0),


            const SizedBox(height: 10.0),
          ],
        ),
      ),



      bottomNavigationBar: Container(
        height: 50.0,
        child: ElevatedButton(
          child: const Text(
            "ADD TO CART",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: (){},
        ),
      ),
    );
  }
}

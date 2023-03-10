import 'package:flutter/material.dart';

import 'details.dart';

class SliderItem extends StatelessWidget {

  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;


  const SliderItem({
    Key? key,
    required this.name,
    required this.img,
    required this.isFav,
    required this.rating,
    required this.raters})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    img,
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
                bottom:10,
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black54,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 2,
                ),
              ),
            ],


          ),





        ],
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context){
              return ProductDetails();
            },
          ),
        );
      },
    );
  }
}

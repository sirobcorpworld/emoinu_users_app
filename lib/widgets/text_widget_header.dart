import 'package:flutter/material.dart';



class TextWidgetHeader extends SliverPersistentHeaderDelegate
{
  String? title;
  TextWidgetHeader({this.title});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent,)
  {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
              color:  const Color(0xff7986cb),
          ),
          // height: MediaQuery.of(context).size.height*0.1,
          // width: MediaQuery.of(context).size.width*0.5,
          alignment: Alignment.center,
          child: Text(
            title!,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 25,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

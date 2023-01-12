import 'package:flutter/material.dart';
import 'package:emoinu_users_app/mainScreens/item_detail_screen.dart';
import 'package:emoinu_users_app/models/items.dart';


class ItemsDesignWidget extends StatefulWidget
{
  final Items? model;
  final BuildContext? context;

  const ItemsDesignWidget({Key? key, this.model, this.context}) : super(key: key);

  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }
  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState(

  );
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  late int likeCount;
  late Map likes;
  bool isLiked=false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0,left:5.0,right: 5.0),
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
              color: Colors.indigo[100],
          ),
          height: MediaQuery.of(context).size.width*0.3,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:  BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl!,
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey[600],
                  ),
                  width: 180.0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                            widget.model!.title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: "Proxima",
                            ),
                          ),
                        ),
                    Expanded(
                      child: Text(
                        widget.model!.shortInfo!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                        Expanded(
                          child: Text(
                            'status : ${widget.model!.status!}',
                            style: const TextStyle(
                              color: Colors.white70,
                          fontSize: 13.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Price : ₹ ${widget.model!.price!.toString()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
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

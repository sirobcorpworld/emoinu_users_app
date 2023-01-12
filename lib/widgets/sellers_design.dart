import 'package:emoinu_users_app/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import '../models/sellers.dart';

class SellersDesignWidget extends StatefulWidget
{
  final Sellers? model;
  final BuildContext? context;

  const SellersDesignWidget({Key? key, this.model, this.context}) : super(key: key);

  @override
  _SellersDesignWidgetState createState() => _SellersDesignWidgetState();
}



class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ProvidedStylesExample(model: widget.model, menuScreenContext: context,)));
      },
      splashColor: Colors.indigo.shade100,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(30.0)
          ),
          height: MediaQuery.of(context).size.height*0.8,
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30.0,
              ),
               const Text(
                'WELCOME TO EMOINU FOODS',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child:
                  Image.asset(
                    'images/welcome.jpg',
                  height: MediaQuery.of(context).size.height*0.5,
                  width: MediaQuery.of(context).size.width*0.6,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30.0,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(30.0),
                  color: Colors.blueGrey.shade600
                ),
                height: 40.0,
                width: MediaQuery.of(context).size.width*0.35,
                child: const Text(
                  "Proceed",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

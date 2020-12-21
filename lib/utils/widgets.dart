import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppWidgets{

  //48, 30, 20, 12
  TextStyle headText(double size){
    return TextStyle(color: Color(0xFF5E56E7), fontSize: size, fontFamily: 'Montserrat Semibold');
  }

  // TextStyle subHeadText(){
  //   return TextStyle(color: Color(0xFF5E56E7), fontSize: 30, fontFamily: 'Montserrat Seminbold');
  // }

  TextStyle titleText(double size){
    return TextStyle(color: Color(0xFF333333), fontSize: size, fontFamily: 'Montserrat');
  }

  // TextStyle bookDetailTextStyle(){
  //   return TextStyle(color: Color(0xFF333333), fontSize: 12, fontFamily: 'Montserrat');
  // }

  Padding cardShimmer(){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Color(0xFF5E56E7),
          highlightColor: Colors.deepPurple[200],
          child:
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(height: 100, width: 80,
                   decoration: BoxDecoration( borderRadius: BorderRadius.circular(5), color: Colors.grey[500]),),
                 SizedBox(height: 8,),

                 Container(height: 10, width: 70, color: Colors.grey[400],),
                 SizedBox(height: 5,),
                 Container(height: 10, width: 50, color: Colors.grey[400],),
               ],
             )
          ),
    );
  }

  GridView shimmerList(){
    return GridView.count(
      padding: EdgeInsets.only(top: 8),
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 3,
      childAspectRatio: 0.7,
      children: List.generate(5, (index){
        return cardShimmer();
      }),
    );
  }

  Column errorColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.deepPurpleAccent, size: 80,),
        SizedBox(height: 20,),
        Text("The book you are searching for is", style: titleText(20),),
        SizedBox(height: 10,),
        Text("CURRENTLY NOT", style: headText(30),),
        Text("AVAILABLE", style: headText(30),),
      ],
    );
  }

  Future<void> showAlertDialog(BuildContext context) async{
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("No viewable version available"),
            actions: [
              FlatButton(child: Text("close"), onPressed: (){Navigator.pop(context);},)
            ],
          );
        }
    );
  }
}


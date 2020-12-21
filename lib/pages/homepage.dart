import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_gutenberg/models/book.dart';
import 'package:project_gutenberg/pages/categorypage.dart';
import 'package:project_gutenberg/utils/api_setup.dart';
import 'package:project_gutenberg/utils/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AppWidgets _appWidgets = new AppWidgets();
  String subheading = "A social cataloging website that allows you to freely search its database of books, annotations, and reviews.";
  ApiSetup _apiSetup = new ApiSetup();
  List<Category> categoryList = new List<Category>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = _apiSetup.getCategories();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0XFFF0F0F6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 30,),
                Text("Gutenberg Project", style: _appWidgets.headText(48),),
                SizedBox(height: 16,),
                Text(subheading, style: _appWidgets.titleText(20),),
                SizedBox(height: 16,),

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        categoryName: categoryList[index].name,
                      );
                    }),
                SizedBox(height: 100,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {

  final String categoryName;
  CategoryTile({this.categoryName});
  AppWidgets _appWidgets = new AppWidgets();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPage(categoryName: categoryName,)));
      },
      child: Card(
        margin: EdgeInsets.only(top: 10),
        elevation: 3,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/images/$categoryName.svg", height: 40, width: 40,),
              SizedBox(width: 16,),
              Text(categoryName, style: _appWidgets.titleText(20),),
              Spacer(),
              Icon(Icons.arrow_forward, color: Color(0xFF5E56E7),),

            ],
          ),
        ),
      ),
    );
  }
}


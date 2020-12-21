import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_gutenberg/models/book.dart';
import 'package:project_gutenberg/pages/pagedetail.dart';
import 'package:project_gutenberg/utils/api_setup.dart';
import 'package:project_gutenberg/utils/widgets.dart';

class CategoryPage extends StatefulWidget {

  String categoryName;
  CategoryPage({this.categoryName});


  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  AppWidgets appWidgets = new AppWidgets();
  ApiSetup apiSetup = new ApiSetup();
  List<Book> bookList = new List<Book>();
  List<Book> filteredBookList = new List<Book>();
  bool isLoading = true;
  ScrollController _controller = new ScrollController();
  int page_number = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList(page_number, widget.categoryName.toLowerCase());
    loadMore();
  }

  getList(int page, String name) async{
    await apiSetup.getData(page, name);
    bookList = apiSetup.bookList;
    setState(() {
      filteredBookList = bookList;
      isLoading = false;
    });
  }

  loadMore() {
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        setState(() {
          page_number += 1;
        });
        getList(page_number, widget.categoryName.toLowerCase());
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName, style: appWidgets.headText(30),),
        backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.deepPurple),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              onChanged: (string){
                setState(() {
                  filteredBookList = bookList.where((u) => (
                      u.title.toLowerCase().contains(string.toLowerCase())
                    )
                  ).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'search',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.deepPurpleAccent,)
              ),
            ),
          ),
        ),
      ),

      body: Container(
          color: Color(0xFFF8F7FF),
          padding: EdgeInsets.all(5),
          child: (isLoading) ? appWidgets.shimmerList() :

          (filteredBookList.length == 0) ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.deepPurpleAccent, size: 80,),
                SizedBox(height: 20,),
                Text("No books available for this category", style: appWidgets.titleText(20),),
              ],
            ),
          ) :

          Container(
            child: GridView.count(
              controller: _controller,
              padding: EdgeInsets.only(top: 8),
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 3,
              childAspectRatio: 0.55,
              children: List.generate(filteredBookList.length, (index){
                final item = filteredBookList[index];
                return BookTile(
                  title: item.title,
                  plaintext: item.formats.plaintext,
                  pdftext: item.formats.pdf,
                  htmtxt: item.formats.html,
                  imageUrl: item.formats.image,
                  subjects: item.subjects,
                  bookshelves: item.bookshelves,
                  cr: item.copyright.toString(),
                  dc: item.downloadcount.toString(),
                  author: (item.authors.length == 0) ? "Author Unavailable" :
                  "${item.authors[0].name} (${item.authors[0].birthyear.toString()} - ${item.authors[0].deathyear.toString()}))",
                );
              }),
            )
          )
        ),
    );
  }
}


class BookTile extends StatelessWidget {

  String title, plaintext, pdftext, htmtxt, imageUrl, cr, dc, author;
  List<String> subjects, bookshelves;
  BookTile({this.title, this.plaintext, this.pdftext, this.htmtxt, this.imageUrl, this.author, this.subjects,
            this.bookshelves, this.cr, this.dc});

  AppWidgets appWidgets = new AppWidgets();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        (plaintext == null && pdftext == null && htmtxt == null) ? appWidgets.showAlertDialog(context) :
        // DialogHelper.open(context, imageUrl, title, plaintext, pdftext, htmtxt) ;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetail(
          title: title,
          imageUrl: imageUrl,
          plaintext: plaintext,
          htmtxt: htmtxt,
          pdftext: pdftext,
          bookshelves: bookshelves,
          author: author,
          cr: cr,
          dc: dc,
          subjects: subjects,
        )));
      },
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
              Container(
                height: 120, width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: (imageUrl == null) ? AssetImage("assets/images/book_thumbnail.png",) : NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              SizedBox(height: 5,),
              Flexible(child: Text(title, style: appWidgets.titleText(12), softWrap: true,)),
              SizedBox(height: 3,),
              Flexible(
                child: Text(author, style: TextStyle(fontSize: 11, color: Color(0xFFA0A0A0)),),
              ),


            ],
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_gutenberg/utils/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bookview.dart';

class BookDetail extends StatefulWidget {

  String title, plaintext, pdftext, htmtxt, imageUrl, cr, dc, author;
  List<String> subjects, bookshelves;

  BookDetail({
      this.title,
      this.plaintext,
      this.pdftext,
      this.htmtxt,
      this.imageUrl,
      this.cr,
      this.dc,
      this.author,
      this.subjects,
      this.bookshelves});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  AppWidgets appWidgets = new AppWidgets();
  String sampleUrl = 'https://ryanbattles.com/static/pdf/magic-of-thinking-big.pdf';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.plaintext);
    print(widget.pdftext);
    print(widget.htmtxt);
  }

  Future<void> lauchUrl(String url) async {
    if(await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true,
        headers: <String, String> {'header_key':'header_value'},
      );
    } else throw 'could not launch $url';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: (widget.imageUrl == null) ? Image.asset("assets/images/book_thumbnail.png", fit: BoxFit.cover,) :
                    Image.network(widget.imageUrl, fit: BoxFit.cover,),
                title: Text(widget.title, style: TextStyle(color: Colors.white),),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(height: 100,),
                        Text("By ${widget.author}", style: appWidgets.headText(30),),
                        Text("${widget.dc} downloads", style: appWidgets.titleText(12),),
                        SizedBox(height: 20,),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  IconButton(icon: Icon(Icons.picture_as_pdf, color: Colors.red,), onPressed: (){lauchUrl(widget.pdftext);}),
                                  Text('PDF'),
                                ],),
                                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  IconButton(icon: Icon(Icons.text_fields, color: Color(0xFF333333)), onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => BookPage(plainUrl: widget.plaintext,)));},),
                                  Text('TEXT'),
                                ],),
                                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  IconButton(icon: Icon(Icons.web_asset_sharp, color: Colors.blue), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BookPage(plainUrl: widget.htmtxt,)));},),
                                  Text('WEB'),
                                ],),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),
                        Text("Bookshelves :", style: appWidgets.titleText(20),),
                        SizedBox(height: 5,),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.bookshelves.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(widget.bookshelves[index].toString()),
                                );
                              }),
                        ),

                        SizedBox(height: 20,),
                        Text("Subjects :", style: appWidgets.titleText(20),),
                        SizedBox(height: 5,),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.subjects.length,
                              itemBuilder: (context, index){
                                final sub = widget.subjects[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(sub.toString()),
                                );
                              }),
                        ),


                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}


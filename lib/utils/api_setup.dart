import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_gutenberg/models/book.dart';

class ApiSetup{

  String topicUrl = "http://gutendex.com/books/?page=3&topic=politics";
  String url = "";
  var jsonData;
  List<Book> bookList = [];

  Future<void> getData(int page, String name)  async{

    url = "http://skunkworks.ignitesol.com:8000/books/?page=$page&topic=$name";

    http.Response response = await http.get(url);
    jsonData = jsonDecode(response.body);

    for(Map book in jsonData['results']){
      // if(book['formats']['image/jpeg'] != null)
      bookList.add(Book.fromJson(book));
    }
  }


  List<Category> getCategories(){
    List<Category> categoryList = new List<Category>();
    Category model ;

    model = new Category();
    model.name = "Adventure";
    categoryList.add(model);

    //2
    model = new Category();
    model.name = "Drama";
    categoryList.add(model);

    //3
    model = new Category();
    model.name = "Fiction";
    categoryList.add(model);


    //4
    model = new Category();
    model.name = "History";
    categoryList.add(model);

    //5
    model = new Category();
    model.name = "Humour";
    categoryList.add(model);

    //6
    model = new Category();
    model.name = "Philosophy";
    categoryList.add(model);

    //7
    model = new Category();
    model.name = "Politics";
    categoryList.add(model);

    return categoryList;

  }

}





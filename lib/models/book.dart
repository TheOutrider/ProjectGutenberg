class Book{
  int id;
  String title;
  bool copyright;
  String mediatype;
  int downloadcount;
  List<String> subjects;
  List<String> bookshelves;
  List<String> languages;
  List<Author> authors;
  Formats formats;

  Book({this.id, this.title, this.copyright, this.mediatype, this.downloadcount,
    this.subjects, this.bookshelves, this.languages, this.authors, this.formats});

  factory Book.fromJson(Map<dynamic, dynamic> parsedJson){

    var aList = parsedJson['authors'] as List;
    print(aList.runtimeType);
    List<Author> authorList = aList.map((i) => Author.fromJson(i)).toList();

    return new Book(
      id: parsedJson['id'] == null ? null : parsedJson['id'],
      title: parsedJson['title'] == null ? null : parsedJson['title'],
      copyright: parsedJson['copyright'] == null ? null : parsedJson['copyright'],
      mediatype: parsedJson['media_type'] == null ? null : parsedJson['media_type'],
      downloadcount: parsedJson['download_count'] == null ? null : parsedJson['download_count'],
      subjects: parsedJson['subjects'].cast<String>(),
      bookshelves: parsedJson['bookshelves'].cast<String>(),
      languages: parsedJson['languages'].cast<String>(),
      // authors: parsedJson['authors'].cast<String>(),
      authors: authorList,
      formats: Formats.fromJson(parsedJson['formats'],),

    );
  }

}
class Author{
  String name;
  int birthyear;
  int deathyear;

  Author({this.name, this.birthyear, this.deathyear});

  factory Author.fromJson(Map<dynamic, dynamic> map) {
    return new Author(
      name: map['name'] == null ? null : map['name'],
      birthyear: map['birth_year'] == null ? null : map['birth_year'],
      deathyear: map['death_year'] == null ? null : map['death_year'],
    );
  }
}

class Formats{
  String rdf, ebook, zip, html, epubzip,  asciitext, image,  plaintext, pdf;

  Formats({this.rdf, this.ebook, this.zip, this.html, this.epubzip,
    this.asciitext, this.image, this.plaintext, this.pdf});

  factory Formats.fromJson(Map<String, dynamic> map) {
    return new Formats(
      rdf: map['application/rdf+xml'] == null ? null : map['application/rdf+xml'],
      ebook: map['application/x-mobipocket-ebook'] == null ? null : map['application/x-mobipocket-ebook'],
      zip: map['application/zip'] == null ? null : map['application/zip'],
      html: map['text/html; charset=utf-8'] == null ? null : map['text/html; charset=utf-8'],
      epubzip: map['application/epub+zip'] == null ? null : map['application/epub+zip'],
      asciitext: map['text/plain; charset=us-ascii'] == null ? null : map['text/plain; charset=us-ascii'],
      image: map['image/jpeg'] == null ? null : map['image/jpeg'],
      plaintext: map['text/plain; charset=utf-8'] == null ? null : map['text/plain; charset=utf-8'],
      pdf: map['application/pdf'] == null ? null : map['application/pdf'],
    );
  }
}

class Category{
  String name;
  Category({this.name});
}
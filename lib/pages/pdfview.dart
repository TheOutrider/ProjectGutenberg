// import 'dart:async';
// import 'dart:io';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:project_gutenberg/utils/widgets.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PdfPage extends StatefulWidget {
//
//   String pdfUrl;
//   PdfPage({this.pdfUrl});
//
//   @override
//   _PdfPageState createState() => _PdfPageState();
// }
//
// class _PdfPageState extends State<PdfPage> {
//
//   final Completer<WebViewController> _completer = Completer<WebViewController>();
//   AppWidgets appWidgets = new AppWidgets();
//   String localFile;
//   String url ;
//
//   static Future<String>  loadPdf(String url) async{
//     var response = await http.get("http://www.gutenberg.org/files/2591/2591-pdf.pdf");
//     var dir = await getTemporaryDirectory();
//     File file = new File(dir.path + "");
//     await file.writeAsBytes(response.bodyBytes, flush: true);
//     return file.path;
//   }
//
//   Future<void> lauchUrl(String url) async {
//     if(await canLaunch(url)) {
//       await launch(url, forceSafariVC: false, forceWebView: false,
//           headers: <String, String> {'header_key':'header_value'},
//       );
//     } else throw 'could not launch $url';
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     url = widget.pdfUrl;
//     loadPdf(url).then((value){
//       setState(() {
//         localFile = value;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//             child: Text("Sample")
//
//         //Container(
//
//
//
//             //child:localFile != null ? Container(child: PDFView(filePath: localFile,),) : Center(child: CircularProgressIndicator())
//
//
//
//           // child: (sampleUrl == null) ? Center(child: appWidgets.errorColumn()) :
//           // WebView(
//           //     initialUrl: sampleUrl,
//           //     onWebViewCreated: (WebViewController webViewController){
//           //       setState(() {
//           //         isLoading = false;
//           //       });
//           //       print(isLoading);
//           //       _completer.complete(webViewController);
//           //     }
//           // )
//        // ),
//       ),
//     );
//   }
// }

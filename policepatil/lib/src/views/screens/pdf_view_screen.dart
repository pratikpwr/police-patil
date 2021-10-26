import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewScreen extends StatelessWidget {
  const PDFViewScreen({Key? key, required this.title, required this.link})
      : super(key: key);
  final String title;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SfPdfViewer.network("http://$link")),
    );
  }
}

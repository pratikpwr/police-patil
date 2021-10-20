import 'package:flutter/material.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SelfCertificateScreen extends StatelessWidget {
  SelfCertificateScreen({Key? key}) : super(key: key);
  String url =
      "https://pp.thesupernest.com/uploads/payment/payment_police_patil.pdf";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("हजेरीबाबतचे स्वयंघोषणापत्र")),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: SfPdfViewer.network(url)),
              spacer(),
              CustomButton(
                  text: "Generate हजेरीबाबतचे स्वयंघोषणापत्र",
                  onTap: () {
                    launchUrl(url);
                    Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

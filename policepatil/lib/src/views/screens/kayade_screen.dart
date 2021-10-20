import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class KayadeScreen extends StatelessWidget {
  const KayadeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<KayadeBloc>(context).add(GetKayade());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            LAWS,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocListener<KayadeBloc, KayadeState>(listener: (context, state) {
          if (state is KayadeLoadError) {
            showSnackBar(context, state.error);
          }
        }, child: BlocBuilder<KayadeBloc, KayadeState>(
          builder: (context, state) {
            if (state is KayadeLoading) {
              return Loading();
            } else if (state is KayadeLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.kayadeResponse.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          KayadeData kayadeData =
                              state.kayadeResponse.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    primary: CONTAINER_BACKGROUND_COLOR,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  kayadeData.title!,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return PDFViewScreen(
                                        kayadeData: kayadeData);
                                  }));
                                }),
                          );
                        })),
              );
            } else if (state is KayadeLoadError) {
              if (state.error == 'Record Empty') {
                return NoRecordFound();
              } else {
                return SomethingWentWrong();
              }
            } else {
              return SomethingWentWrong();
            }
          },
        )));
  }
}

class PDFViewScreen extends StatelessWidget {
  const PDFViewScreen({Key? key, required this.kayadeData}) : super(key: key);
  final KayadeData kayadeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kayadeData.title!,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SfPdfViewer.network("http://${kayadeData.file!}")),
    );
  }
}

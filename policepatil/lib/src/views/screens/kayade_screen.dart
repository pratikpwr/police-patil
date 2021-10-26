import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class KayadeScreen extends StatelessWidget {
  const KayadeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<KayadeBloc>(context).add(GetKayade());
    return Scaffold(
        appBar: AppBar(title: const Text(LAWS)),
        body: BlocListener<KayadeBloc, KayadeState>(listener: (context, state) {
          if (state is KayadeLoadError) {
            showSnackBar(context, state.error);
          }
        }, child: BlocBuilder<KayadeBloc, KayadeState>(
          builder: (context, state) {
            if (state is KayadeLoading) {
              return const Loading();
            } else if (state is KayadeLoaded) {
              if (state.kayadeResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
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
                                    overflow: TextOverflow.fade,
                                    style: Styles.buttonTextStyle(
                                        color: Colors.black87),
                                  ),
                                  onPressed: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return PDFViewScreen(
                                        title: kayadeData.title!,
                                        link: kayadeData.file!,
                                      );
                                    }));
                                  }),
                            );
                          })),
                );
              }
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

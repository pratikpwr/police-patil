import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/screens/register/arms_register.dart';
import 'package:shared/shared.dart';

class ArmsScreen extends StatelessWidget {
  const ArmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ARMS_COLLECTIONS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<ArmsRegisterBloc, ArmsRegisterState>(
        listener: (context, state) {
          if (state is ArmsLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<ArmsRegisterBloc, ArmsRegisterState>(
          builder: (context, state) {
            if (state is ArmsDataLoading) {
              return loading();
            } else if (state is ArmsDataLoaded) {
              if (state.armsResponse.data.isEmpty) {
                return noRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.armsResponse.data.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ArmsDetailWidget(
                              armsData: state.armsResponse.data[index],
                            );
                          })),
                );
              }
            } else if (state is ArmsLoadError) {
              return somethingWentWrong();
            } else {
              return somethingWentWrong();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const ArmsRegFormScreen();
          })).then((value) {
            BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class ArmsDetailWidget extends StatelessWidget {
  const ArmsDetailWidget({Key? key, required this.armsData}) : super(key: key);
  final ArmsData armsData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      armsData.type!,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    Text(
                      armsData.name!,
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    Text(
                      armsData.mobile.toString(),
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      armsData.address!,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      "परवाना क्रमांक : ${armsData.licenceNumber}",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      "परवान्याची वैधता कालावधी : ${armsData.validity!.toIso8601String()}",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: GREY_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              armsData.type!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              armsData.name!,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Text(
              armsData.address!,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const Divider(),
            Text(
              "परवाना क्रमांक : ${armsData.licenceNumber}",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

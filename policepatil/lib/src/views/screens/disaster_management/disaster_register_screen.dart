import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class DisasterRegScreen extends StatelessWidget {
  const DisasterRegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisasterRegisterBloc>(context).add(GetDisasterData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          REGISTER_DISASTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<DisasterRegisterBloc, DisasterRegisterState>(
        listener: (context, state) {
          if (state is DisasterLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<DisasterRegisterBloc, DisasterRegisterState>(
          builder: (context, state) {
            if (state is DisasterDataLoading) {
              return loading();
            } else if (state is DisasterDataLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.disasterResponse.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return DisasterDetailWidget(
                            disasterData: state.disasterResponse.data![index],
                          );
                        })),
              );
            } else if (state is DisasterLoadError) {
              if (state.message == 'Record Empty') {
                return noRecordFound();
              } else {
                return somethingWentWrong();
              }
            } else {
              return somethingWentWrong();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const DisasterRegFormScreen();
          })).then((value) {
            BlocProvider.of<DisasterRegisterBloc>(context)
                .add(GetDisasterData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class DisasterDetailWidget extends StatelessWidget {
  const DisasterDetailWidget({Key? key, required this.disasterData})
      : super(key: key);
  final DisasterData disasterData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              disasterData.type!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              disasterData.subtype!,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            const Divider(),
            Text(
              disasterData.date!.toIso8601String().substring(0, 10),
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

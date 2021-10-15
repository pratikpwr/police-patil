import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

class FiresScreen extends StatelessWidget {
  const FiresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FireRegisterBloc>(context).add(GetFireData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BURNS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<FireRegisterBloc, FireRegisterState>(
        listener: (context, state) {
          if (state is FireLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<FireRegisterBloc, FireRegisterState>(
          builder: (context, state) {
            if (state is FireDataLoading) {
              return Loading();
            } else if (state is FireDataLoaded) {
              if (state.fireResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.fireResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FireDetailWidget(
                              fireData: state.fireResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is FireLoadError) {
              return SomethingWentWrong();
            } else {
              return SomethingWentWrong();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const FireRegFormScreen();
          })).then((value) {
            BlocProvider.of<FireRegisterBloc>(context).add(GetFireData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class FireDetailWidget extends StatelessWidget {
  const FireDetailWidget({Key? key, required this.fireData}) : super(key: key);
  final FireData fireData;

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
              fireData.address!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              fireData.date!.toIso8601String(),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

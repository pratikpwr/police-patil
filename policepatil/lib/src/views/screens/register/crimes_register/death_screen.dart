import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

class DeathScreen extends StatelessWidget {
  const DeathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DeathRegisterBloc>(context).add(GetDeathData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DEATHS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<DeathRegisterBloc, DeathRegisterState>(
        listener: (context, state) {
          if (state is DeathLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<DeathRegisterBloc, DeathRegisterState>(
          builder: (context, state) {
            if (state is DeathDataLoading) {
              return loading();
            } else if (state is DeathDataLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.deathResponse.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return DeathDetailWidget(
                            deathData: state.deathResponse.data![index],
                          );
                        })),
              );
            } else if (state is DeathLoadError) {
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
            return const DeathRegFormScreen();
          })).then((value) {
            BlocProvider.of<DeathRegisterBloc>(context).add(GetDeathData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class DeathDetailWidget extends StatelessWidget {
  const DeathDetailWidget({Key? key, required this.deathData})
      : super(key: key);
  final DeathData deathData;

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
              deathData.foundAddress!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              deathData.gender!,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class MovementScreen extends StatelessWidget {
  const MovementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovementRegisterBloc>(context).add(GetMovementData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MOVEMENT_REGISTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<MovementRegisterBloc, MovementRegisterState>(
        listener: (context, state) {
          if (state is MovementLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<MovementRegisterBloc, MovementRegisterState>(
          builder: (context, state) {
            if (state is MovementDataLoading) {
              return loading();
            } else if (state is MovementDataLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.movementResponse.movementData!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MovementDetailWidget(
                            movementData:
                                state.movementResponse.movementData![index],
                          );
                        })),
              );
            } else if (state is MovementLoadError) {
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
            return const MovementRegFormScreen();
          })).then((value) {
            BlocProvider.of<MovementRegisterBloc>(context)
                .add(GetMovementData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class MovementDetailWidget extends StatelessWidget {
  const MovementDetailWidget({Key? key, required this.movementData})
      : super(key: key);
  final MovementData movementData;

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
              movementData.type!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              movementData.subtype!,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              movementData.description!,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            Text(
              "$ATTENDANCE : ${movementData.attendance!}",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const Divider(),
            Text(
              movementData.address!,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            Text(
              movementData.datetime!.toIso8601String(),
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

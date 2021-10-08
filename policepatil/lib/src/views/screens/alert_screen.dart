import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlertBloc>(context).add(GetAlerts());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            NOTICE,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          automaticallyImplyLeading: false,
        ),
        body: BlocListener<AlertBloc, AlertState>(listener: (context, state) {
          if (state is AlertLoadError) {}
        }, child: BlocBuilder<AlertBloc, AlertState>(
          builder: (context, state) {
            if (state is AlertLoading) {
              return loading();
            } else if (state is AlertLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.alertResponse.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AlertDetailsWidget(
                            alertData: state.alertResponse.data![index],
                          );
                        })),
              );
            } else if (state is AlertLoadError) {
              if (state.error == 'Record Empty') {
                return noRecordFound();
              } else {
                return somethingWentWrong();
              }
            } else {
              return somethingWentWrong();
            }
          },
        )));
  }
}

class AlertDetailsWidget extends StatelessWidget {
  final AlertData alertData;

  const AlertDetailsWidget({Key? key, required this.alertData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: GREY_BACKGROUND_COLOR),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Todo network image
          // Todo add youtube player
          // Todo onTap for external link
          // Todo see doc button
          Text(
            alertData.title!,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Divider(),
          Text(
            alertData.date!.toIso8601String().substring(0, 10),
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

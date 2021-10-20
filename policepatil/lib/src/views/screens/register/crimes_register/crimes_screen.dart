import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/styles.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

class CrimesScreen extends StatelessWidget {
  const CrimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CrimeRegisterBloc>(context).add(GetCrimeData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(CRIMES),
      ),
      body: BlocListener<CrimeRegisterBloc, CrimeRegisterState>(
        listener: (context, state) {
          if (state is CrimeLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<CrimeRegisterBloc, CrimeRegisterState>(
          builder: (context, state) {
            if (state is CrimeDataLoading) {
              return const Loading();
            } else if (state is CrimeDataLoaded) {
              if (state.crimeResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.crimeResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CrimeDetailWidget(
                              crimesData: state.crimeResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is CrimeLoadError) {
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
            return const CrimeRegFormScreen();
          })).then((value) {
            BlocProvider.of<CrimeRegisterBloc>(context).add(GetCrimeData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class CrimeDetailWidget extends StatelessWidget {
  const CrimeDetailWidget({Key? key, required this.crimesData})
      : super(key: key);
  final CrimeData crimesData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CONTAINER_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(crimesData.type!, style: Styles.primaryTextStyle()),
            const Divider(),
            HeadValueText(
                title: "गुन्हा रजिस्टर नंबर",
                value: "${crimesData.registerNumber}"),
            HeadValueText(title: DATE, value: showDate(crimesData.date!)),
          ],
        ),
      ),
    );
  }
}

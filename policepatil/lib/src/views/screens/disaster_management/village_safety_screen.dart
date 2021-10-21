import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class VillageSafetyScreen extends StatelessWidget {
  const VillageSafetyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<VillageSafetyBloc>(context).add(GetVillageSafetyData());
    return Scaffold(
      appBar: AppBar(title: const Text(VILLAGE_SAFETY)),
      body: BlocListener<VillageSafetyBloc, VillageSafetyState>(
        listener: (context, state) {
          if (state is VillageSafetyLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<VillageSafetyBloc, VillageSafetyState>(
          builder: (context, state) {
            if (state is VillageSafetyDataLoading) {
              return const Loading();
            } else if (state is VillageSafetyDataLoaded) {
              if (state.safetyResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.safetyResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return VillageSafetyDetailWidget(
                              helperData: state.safetyResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is VillageSafetyLoadError) {
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
            return const VillageSafetyRegisterForm();
          })).then((value) {
            BlocProvider.of<VillageSafetyBloc>(context)
                .add(GetVillageSafetyData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class VillageSafetyDetailWidget extends StatelessWidget {
  const VillageSafetyDetailWidget({Key? key, required this.helperData})
      : super(key: key);
  final VillageSafetyData helperData;

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
            Text(
              helperData.skill!,
              style: Styles.primaryTextStyle(),
            ),
            const Divider(),
            Text(
              helperData.name!,
              style: Styles.subTitleTextStyle(),
            ),
            Text(
              helperData.mobile!.toString(),
              style: Styles.subTitleTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

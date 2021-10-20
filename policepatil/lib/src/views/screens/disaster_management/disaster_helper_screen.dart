import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class DisasterManageHelperScreen extends StatelessWidget {
  const DisasterManageHelperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisasterHelperBloc>(context).add(GetHelperData());
    return Scaffold(
      appBar: AppBar(title: const Text(DISASTER_HELPER)),
      body: BlocListener<DisasterHelperBloc, DisasterHelperState>(
        listener: (context, state) {
          if (state is HelperLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<DisasterHelperBloc, DisasterHelperState>(
          builder: (context, state) {
            if (state is HelperDataLoading) {
              return const Loading();
            } else if (state is HelperDataLoaded) {
              if (state.helperResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.helperResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return HelperDetailWidget(
                              helperData: state.helperResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is HelperLoadError) {
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
            return const DisasterHelperRegisterForm();
          })).then((value) {
            BlocProvider.of<DisasterHelperBloc>(context).add(GetHelperData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class HelperDetailWidget extends StatelessWidget {
  const HelperDetailWidget({Key? key, required this.helperData})
      : super(key: key);
  final HelperData helperData;

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

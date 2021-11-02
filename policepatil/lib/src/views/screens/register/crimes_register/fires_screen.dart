import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

class FiresScreen extends StatelessWidget {
  const FiresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FireRegisterBloc>(context).add(GetFireData());
    return Scaffold(
      appBar: AppBar(title: const Text(BURNS)),
      body: BlocListener<FireRegisterBloc, FireRegisterState>(
        listener: (context, state) {
          if (state is FireLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<FireRegisterBloc, FireRegisterState>(
          builder: (context, state) {
            if (state is FireDataLoading) {
              return const Loading();
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
      onTap: () {
        _showDetails(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CONTAINER_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadValueText(title: PLACE, value: fireData.address ?? "-"),
            HeadValueText(title: DATE, value: showDate(fireData.date!)),
            HeadValueText(title: "आगीचे कारण", value: fireData.reason ?? "-"),
            HeadValueText(title: "अंदाजे नुकसान", value: fireData.loss ?? "-"),
          ],
        ),
      ),
    );
  }

  _showDetails(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (ctx) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadValueText(title: PLACE, value: fireData.address ?? "-"),
                  HeadValueText(title: DATE, value: showDate(fireData.date!)),
                  HeadValueText(
                      title: "आगीचे कारण", value: fireData.reason ?? "-"),
                  HeadValueText(
                      title: "अंदाजे नुकसान", value: fireData.loss ?? "-"),
                  spacer(height: 8),
                  if (fireData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (fireData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${fireData.photo!}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

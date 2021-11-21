import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/styles.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class MovementScreen extends StatelessWidget {
  const MovementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovementRegisterBloc>(context).add(GetMovementData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(MOVEMENT_REGISTER),
      ),
      body: BlocListener<MovementRegisterBloc, MovementRegisterState>(
        listener: (context, state) {
          if (state is MovementLoadError) {
            showSnackBar(context, state.message);
          }
          if (state is MovementDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<MovementRegisterBloc>(context)
                .add(GetMovementData());
          }
        },
        child: BlocBuilder<MovementRegisterBloc, MovementRegisterState>(
          builder: (context, state) {
            if (state is MovementDataLoading) {
              return const Loading();
            } else if (state is MovementDataLoaded) {
              if (state.movementResponse.movementData!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount:
                              state.movementResponse.movementData!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final movementData =
                                state.movementResponse.movementData![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, movementData);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: CONTAINER_BACKGROUND_COLOR),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(movementData.type!,
                                            style: Styles.primaryTextStyle()),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                _navigateToRegister(context,
                                                    movementData: movementData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            MovementRegisterBloc>(
                                                        context)
                                                    .add(DeleteMovementData(
                                                        movementData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(movementData.subtype!,
                                        style: Styles.primaryTextStyle()),
                                    const Divider(),
                                    HeadValueText(
                                        title: DESCRIPTION,
                                        value: movementData.description ?? "-"),
                                    HeadValueText(
                                        title: ADDRESS,
                                        value: movementData.address ?? "-"),
                                    HeadValueText(
                                        title: ATTENDANCE,
                                        value:
                                            "${movementData.attendance ?? 0}"),
                                    HeadValueText(
                                        title: DATE,
                                        value:
                                            showDate(movementData.datetime!)),
                                  ],
                                ),
                              ),
                            );
                          })),
                );
              }
            } else if (state is MovementLoadError) {
              return SomethingWentWrong();
            } else {
              return SomethingWentWrong();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToRegister(context);
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  _navigateToRegister(BuildContext context, {MovementData? movementData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return MovementRegFormScreen(movementData: movementData);
    })).then((value) {
      BlocProvider.of<MovementRegisterBloc>(context).add(GetMovementData());
    });
  }

  _showDetails(BuildContext context, MovementData movementData) {
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
                  Text(movementData.type!, style: Styles.primaryTextStyle()),
                  Text(movementData.subtype!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(
                      title: ADDRESS, value: movementData.address ?? "-"),
                  HeadValueText(
                      title: DATE, value: showDate(movementData.datetime!)),
                  HeadValueText(
                      title: DESCRIPTION,
                      value: movementData.description ?? "-"),
                  HeadValueText(
                      title: "नेतृत्त्व करणाऱ्या व्यक्तीचे नाव",
                      value: movementData.leader ?? "-"),
                  HeadValueText(
                      title: ATTENDANCE,
                      value: "${movementData.attendance ?? 0}"),
                  HeadValueText(
                      title: IS_ISSUE, value: movementData.issue! ? YES : NO),
                  spacer(height: 8),
                  if (movementData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (movementData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${movementData.photo!}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

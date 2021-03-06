import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

class MissingScreen extends StatelessWidget {
  const MissingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MissingRegisterBloc>(context).add(GetMissingData());
    return Scaffold(
      appBar: AppBar(title: const Text(MISSING)),
      body: BlocListener<MissingRegisterBloc, MissingRegisterState>(
        listener: (context, state) {
          if (state is MissingLoadError) {
            showSnackBar(context, state.message);
          }
          if (state is MissingDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<MissingRegisterBloc>(context).add(GetMissingData());
          }
        },
        child: BlocBuilder<MissingRegisterBloc, MissingRegisterState>(
          builder: (context, state) {
            if (state is MissingDataLoading) {
              return const Loading();
            } else if (state is MissingDataLoaded) {
              if (state.missingResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.missingResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final missingData =
                                state.missingResponse.data![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, missingData);
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
                                        HeadValueText(
                                            title: "?????? ??????????????????????????? ????????? ?????? ?",
                                            value: missingData.isAdult!
                                                ? YES
                                                : NO),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                _navigateToRegister(context,
                                                    missingData: missingData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            MissingRegisterBloc>(
                                                        context)
                                                    .add(DeleteMissingData(
                                                        missingData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: NAME,
                                        value: missingData.name ?? "-"),
                                    HeadValueText(
                                        title: ADDRESS,
                                        value: missingData.address ?? "-"),
                                    HeadValueText(
                                        title: "????????????",
                                        value: missingData.gender ?? "-"),
                                  ],
                                ),
                              ),
                            );
                          })),
                );
              }
            } else if (state is MissingLoadError) {
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

  _navigateToRegister(BuildContext context, {MissingData? missingData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return MissingRegFormScreen(missingData: missingData);
    })).then((value) {
      BlocProvider.of<MissingRegisterBloc>(context).add(GetMissingData());
    });
  }

  _showDetails(BuildContext context, MissingData missingData) {
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
                  HeadValueText(
                      title: "?????? ??????????????????????????? ????????? ?????? ?",
                      value: missingData.isAdult! ? YES : NO),
                  HeadValueText(title: NAME, value: missingData.name ?? "-"),
                  HeadValueText(title: AGE, value: "${missingData.age}"),
                  HeadValueText(
                      title: ADDRESS, value: missingData.address ?? "-"),
                  HeadValueText(
                      title: "????????????", value: missingData.gender ?? "-"),
                  spacer(height: 8),
                  if (missingData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (missingData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${missingData.photo!}",
                      width: 300,
                    ),
                  spacer(height: 8),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/heading_value_text_widget.dart';
import '../bloc/death_register_bloc.dart';
import '../models/death_model.dart';
import 'death_register_screen.dart';

class DeathScreen extends StatelessWidget {
  const DeathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DeathRegisterBloc>(context).add(GetDeathData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(DEATHS),
      ),
      body: BlocListener<DeathRegisterBloc, DeathRegisterState>(
        listener: (context, state) {
          if (state is DeathLoadError) {
            showSnackBar(context, state.message);
          }
          if (state is DeathDataDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<DeathRegisterBloc>(context).add(GetDeathData());
          }
        },
        child: BlocBuilder<DeathRegisterBloc, DeathRegisterState>(
          builder: (context, state) {
            if (state is DeathDataLoading) {
              return const Loading();
            } else if (state is DeathDataLoaded) {
              if (state.deathResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.deathResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final deathData = state.deathResponse.data![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, deathData);
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
                                            title: "ओळख पटलेली आहे का ?",
                                            value:
                                                deathData.isKnown! ? YES : NO),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                _navigateToRegister(context,
                                                    deathData: deathData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            DeathRegisterBloc>(
                                                        context)
                                                    .add(DeleteDeathData(
                                                        deathData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: "मरणाचे प्राथमिक कारण",
                                        value: deathData.causeOfDeath ?? "-"),
                                    HeadValueText(
                                        title: "कोठे सापडले ठिकाण",
                                        value: deathData.foundAddress ?? "-"),
                                    HeadValueText(
                                        title: "लिंग",
                                        value: deathData.gender ?? "-"),
                                  ],
                                ),
                              ),
                            );
                          })),
                );
              }
            } else if (state is DeathLoadError) {
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

  _navigateToRegister(BuildContext context, {DeathData? deathData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DeathRegFormScreen(deathData: deathData);
    })).then((value) {
      BlocProvider.of<DeathRegisterBloc>(context).add(GetDeathData());
    });
  }

  _showDetails(BuildContext context, DeathData deathData) {
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
                      title: "ओळख पटलेली आहे का ?",
                      value: deathData.isKnown! ? YES : NO),
                  deathData.isKnown!
                      ? HeadValueText(title: NAME, value: deathData.name ?? "-")
                      : spacer(height: 0),
                  deathData.isKnown!
                      ? HeadValueText(
                          title: ADDRESS, value: deathData.address ?? "-")
                      : spacer(height: 0),
                  HeadValueText(
                      title: "मरणाचे प्राथमिक कारण",
                      value: deathData.causeOfDeath ?? "-"),
                  HeadValueText(
                      title: "कोठे सापडले ठिकाण",
                      value: deathData.address ?? "-"),
                  HeadValueText(title: "लिंग", value: deathData.gender ?? "-"),
                  spacer(height: 8),
                  if (deathData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (deathData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${deathData.photo!}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

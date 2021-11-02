import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/styles.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

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
                            return DeathDetailWidget(
                              deathData: state.deathResponse.data![index],
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
            HeadValueText(
                title: "ओळख पटलेली आहे का ?",
                value: deathData.isKnown! ? YES : NO),
            HeadValueText(
                title: "मरणाचे प्राथमिक कारण",
                value: deathData.causeOfDeath ?? "-"),
            HeadValueText(
                title: "कोठे सापडले ठिकाण",
                value: deathData.foundAddress ?? "-"),
            HeadValueText(title: "लिंग", value: deathData.gender ?? "-"),
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

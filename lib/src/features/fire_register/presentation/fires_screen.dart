import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/heading_value_text_widget.dart';
import '../bloc/fire_register_bloc.dart';
import '../models/fire_model.dart';
import 'fires_register_screen.dart';

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
          if (state is FireDataDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<FireRegisterBloc>(context).add(GetFireData());
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
                            final fireData = state.fireResponse.data![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, fireData);
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
                                            title: PLACE,
                                            value: fireData.address ?? "-"),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                _navigateToRegister(context,
                                                    fireData: fireData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            FireRegisterBloc>(
                                                        context)
                                                    .add(DeleteFireData(
                                                        fireData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: DATE,
                                        value: showDate(fireData.date!)),
                                    HeadValueText(
                                        title: "आगीचे कारण",
                                        value: fireData.reason ?? "-"),
                                    HeadValueText(
                                        title: "अंदाजे नुकसान",
                                        value: fireData.loss ?? "-"),
                                  ],
                                ),
                              ),
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
          _navigateToRegister(context);
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  _navigateToRegister(BuildContext context, {FireData? fireData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return FireRegFormScreen(fireData: fireData);
    })).then((value) {
      BlocProvider.of<FireRegisterBloc>(context).add(GetFireData());
    });
  }

  _showDetails(BuildContext context, FireData fireData) {
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

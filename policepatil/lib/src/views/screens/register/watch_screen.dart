import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WatchRegisterBloc>(context).add(GetWatchData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(WATCH_REGISTER),
      ),
      body: BlocListener<WatchRegisterBloc, WatchRegisterState>(
        listener: (context, state) {
          if (state is WatchLoadError) {
            showSnackBar(context, state.message.substring(0, 200));
          }
        },
        child: BlocBuilder<WatchRegisterBloc, WatchRegisterState>(
          builder: (context, state) {
            if (state is WatchDataLoading) {
              return const Loading();
            } else if (state is WatchDataLoaded) {
              if (state.watchResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.watchResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return WatchDetailWidget(
                              watchData: state.watchResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is WatchLoadError) {
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
            return const WatchRegFormScreen();
          })).then((value) {
            BlocProvider.of<WatchRegisterBloc>(context).add(GetWatchData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class WatchDetailWidget extends StatelessWidget {
  const WatchDetailWidget({Key? key, required this.watchData})
      : super(key: key);
  final WatchData watchData;

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
            Text(
              watchData.type!,
              style: Styles.primaryTextStyle(),
            ),
            const Divider(),
            HeadValueText(title: NAME, value: watchData.name ?? "-"),
            HeadValueText(
                title: DESCRIPTION, value: watchData.description ?? "-"),
            HeadValueText(title: ADDRESS, value: watchData.address ?? "-"),
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
                  Text(watchData.type!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(title: DATE, value: watchData.name ?? "-"),
                  HeadValueText(title: DATE, value: "${watchData.mobile ?? 0}"),
                  HeadValueText(
                      title: ADDRESS, value: watchData.address ?? "-"),
                  HeadValueText(
                      title: DESCRIPTION, value: watchData.description ?? "-"),
                  spacer(height: 8),
                  if (watchData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (watchData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${watchData.photo!}",
                      width: 300,
                    ),
                  spacer(height: 8),
                  if (watchData.aadhar != null)
                    Text(
                      AADHAR,
                      style: Styles.titleTextStyle(),
                    ),
                  if (watchData.aadhar != null)
                    CachedNetworkImage(
                      imageUrl: "http://${watchData.aadhar!}",
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

// ignore: must_be_immutable
class MyWidget extends StatelessWidget {
  MyWidget({Key? key, this.data, required this.child}) : super(key: key);

  dynamic data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return data != null ? child : spacer(height: 0);
  }
}

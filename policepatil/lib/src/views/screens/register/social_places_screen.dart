import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/styles.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class SocialPlaceScreen extends StatefulWidget {
  const SocialPlaceScreen({Key? key}) : super(key: key);

  @override
  State<SocialPlaceScreen> createState() => _SocialPlaceScreenState();
}

class _SocialPlaceScreenState extends State<SocialPlaceScreen> {
  @override
  void initState() {
    BlocProvider.of<PublicPlaceRegisterBloc>(context).add(GetPublicPlaceData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SOCIAL_PLACES),
      ),
      body: BlocListener<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
        listener: (context, state) {
          if (state is PublicPlaceLoadError) {
            showSnackBar(context, state.message);
          }
          if (state is PublicPlaceDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<PublicPlaceRegisterBloc>(context)
                .add(GetPublicPlaceData());
          }
        },
        child: BlocBuilder<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
          builder: (context, state) {
            if (state is PublicPlaceDataLoading) {
              return const Loading();
            } else if (state is PublicPlaceDataLoaded) {
              if (state.placeResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.placeResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final placeData = state.placeResponse.data![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, placeData);
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
                                        Text(
                                          placeData.place!,
                                          style: Styles.primaryTextStyle(),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                _navigateToRegister(context,
                                                    placeData: placeData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            PublicPlaceRegisterBloc>(
                                                        context)
                                                    .add(DeletePublicPlaceData(
                                                        placeData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: ADDRESS,
                                        value: placeData.address ?? "-"),
                                    HeadValueText(
                                        title: IS_ISSUE,
                                        value: placeData.isIssue! ? YES : NO),
                                    HeadValueText(
                                        title: "सीसीटीव्ही बसवला आहे का ?",
                                        value: placeData.isCCTV! ? YES : NO),
                                  ],
                                ),
                              ),
                            );
                          })),
                );
              }
            } else if (state is PublicPlaceLoadError) {
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

  _navigateToRegister(BuildContext context, {PlaceData? placeData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SocialPlacesRegFormScreen(
        placeData: placeData,
      );
    })).then((value) {
      BlocProvider.of<PublicPlaceRegisterBloc>(context)
          .add(GetPublicPlaceData());
    });
  }

  _showDetails(BuildContext context, PlaceData placeData) {
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
                  Text(placeData.place!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(
                      title: ADDRESS, value: placeData.address ?? "-"),
                  HeadValueText(
                      title: DESCRIPTION,
                      value: placeData.issueCondition ?? "-"),
                  HeadValueText(
                      title: ATTENDANCE, value: placeData.issueReason ?? "-"),
                  HeadValueText(
                      title: IS_ISSUE, value: placeData.isIssue! ? YES : NO),
                  HeadValueText(
                      title: "सीसीटीव्ही बसवला आहे का ?",
                      value: placeData.isCCTV! ? YES : NO),
                  HeadValueText(
                      title: "गुन्हा दाखल आहे का ?",
                      value: placeData.isCrimeRegistered! ? YES : NO),
                  spacer(height: 8),
                  if (placeData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (placeData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${placeData.photo!}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

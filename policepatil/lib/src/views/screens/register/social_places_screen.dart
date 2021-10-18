import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/styles.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class SocialPlaceScreen extends StatelessWidget {
  const SocialPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PublicPlaceRegisterBloc>(context).add(GetPublicPlaceData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SOCIAL_PLACES,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
        listener: (context, state) {
          if (state is PublicPlaceLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
          builder: (context, state) {
            if (state is PublicPlaceDataLoading) {
              return Loading();
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
                            return PlaceDetailWidget(
                              placeData: state.placeResponse.data![index],
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
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const SocialPlacesRegFormScreen();
          })).then((value) {
            BlocProvider.of<PublicPlaceRegisterBloc>(context)
                .add(GetPublicPlaceData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class PlaceDetailWidget extends StatelessWidget {
  const PlaceDetailWidget({Key? key, required this.placeData})
      : super(key: key);
  final PlaceData placeData;

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
            color: GREY_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(placeData.place!, style: Styles.primaryTextStyle()),
            const Divider(),
            HeadValueText(title: ADDRESS, value: "${placeData.address}"),
            HeadValueText(
                title: IS_ISSUE, value: placeData.isIssue! ? YES : NO),
            HeadValueText(
                title: "सीसीटीव्ही बसवला आहे का ?",
                value: placeData.isCCTV! ? YES : NO),
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
                  Text(placeData.place!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(title: ADDRESS, value: "${placeData.address}"),
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
                  Text(
                    PHOTO,
                    style: Styles.titleTextStyle(),
                  ),
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

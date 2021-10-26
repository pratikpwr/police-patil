import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/screens/register/arms_register.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class ArmsScreen extends StatelessWidget {
  const ArmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(ARMS_COLLECTIONS),
      ),
      body: BlocListener<ArmsRegisterBloc, ArmsRegisterState>(
        listener: (context, state) {
          if (state is ArmsLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<ArmsRegisterBloc, ArmsRegisterState>(
          builder: (context, state) {
            if (state is ArmsDataLoading) {
              return const Loading();
            } else if (state is ArmsDataLoaded) {
              if (state.armsResponse.data.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.armsResponse.data.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ArmsDetailWidget(
                              armsData: state.armsResponse.data[index],
                            );
                          })),
                );
              }
            } else if (state is ArmsLoadError) {
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
            return const ArmsRegFormScreen();
          })).then((value) {
            BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ArmsDetailWidget extends StatelessWidget {
  const ArmsDetailWidget({Key? key, required this.armsData}) : super(key: key);
  final ArmsData armsData;

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
              armsData.type!,
              style: Styles.primaryTextStyle(),
            ),
            const Divider(),
            HeadValueText(title: NAME, value: armsData.name!),
            HeadValueText(title: MOB_NO, value: "${armsData.mobile}"),
            HeadValueText(title: ADDRESS, value: armsData.address!),
            HeadValueText(
                title: "परवाना क्रमांक", value: "${armsData.licenceNumber}"),
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
                  Text(
                    armsData.type!,
                    style: Styles.primaryTextStyle(),
                  ),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(title: NAME, value: armsData.name!),
                  HeadValueText(title: MOB_NO, value: "${armsData.mobile}"),
                  HeadValueText(title: ADDRESS, value: armsData.address!),
                  HeadValueText(
                      title: "परवाना क्रमांक",
                      value: "${armsData.licenceNumber}"),
                  HeadValueText(
                      title: "परवान्याची वैधता कालावधी",
                      value: armsData.validity!.toIso8601String()),
                  spacer(height: 8),
                  Text(
                    AADHAR,
                    style: Styles.titleTextStyle(),
                  ),
                  CachedNetworkImage(
                    imageUrl: "http://${armsData.aadhar!}",
                    width: 300,
                  ),
                  spacer(height: 8),
                  Text(
                    "परवान्याचा फोटो",
                    style: Styles.titleTextStyle(),
                  ),
                  CachedNetworkImage(
                    imageUrl: "http://${armsData.aadhar!}",
                    width: 300,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

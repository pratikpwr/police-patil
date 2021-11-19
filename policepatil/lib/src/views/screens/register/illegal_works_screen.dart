import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/screens/register/illegal_works_register.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class IllegalScreen extends StatelessWidget {
  const IllegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IllegalRegisterBloc>(context).add(GetIllegalData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(ILLEGAL_WORKS),
      ),
      body: BlocListener<IllegalRegisterBloc, IllegalRegisterState>(
        listener: (context, state) {
          if (state is IllegalLoadError) {
            showSnackBar(context, state.message);
          }
          if (state is IllegalDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<IllegalRegisterBloc>(context).add(GetIllegalData());
          }
        },
        child: BlocBuilder<IllegalRegisterBloc, IllegalRegisterState>(
          builder: (context, state) {
            if (state is IllegalDataLoading) {
              return const Loading();
            } else if (state is IllegalDataLoaded) {
              if (state.illegalResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.illegalResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            IllegalData illegalData =
                                state.illegalResponse.data![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, illegalData);
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
                                          illegalData.type!,
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
                                                    illegalData: illegalData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            IllegalRegisterBloc>(
                                                        context)
                                                    .add(DeleteIllegalData(
                                                        illegalData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: NAME,
                                        value: illegalData.name ?? " - "),
                                    HeadValueText(
                                        title: ADDRESS,
                                        value: illegalData.address ?? "-"),
                                  ],
                                ),
                              ),
                            );
                          })),
                );
              }
            } else if (state is IllegalLoadError) {
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

  _navigateToRegister(BuildContext context, {IllegalData? illegalData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return IllegalWorksFormScreen(
        illegalData: illegalData,
      );
    })).then((value) =>
        BlocProvider.of<IllegalRegisterBloc>(context).add(GetIllegalData()));
  }

  _showDetails(BuildContext context, IllegalData illegalData) {
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
                  Text(illegalData.type!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(title: NAME, value: illegalData.name ?? " - "),
                  HeadValueText(
                      title: ADDRESS, value: illegalData.address ?? "-"),
                  spacer(height: 8),
                  if (illegalData.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (illegalData.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${illegalData.photo!}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

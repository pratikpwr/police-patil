import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  void initState() {
    BlocProvider.of<WatchRegisterBloc>(context).add(GetWatchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(WATCH_REGISTER),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return const WatchFilterDataWidget();
                    });
              },
              icon: const Icon(Icons.filter_alt_rounded))
        ],
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

class WatchFilterDataWidget extends StatefulWidget {
  const WatchFilterDataWidget({Key? key}) : super(key: key);

  @override
  _WatchFilterDataWidgetState createState() => _WatchFilterDataWidgetState();
}

class _WatchFilterDataWidgetState extends State<WatchFilterDataWidget> {
  final _bloc = WatchRegisterBloc();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<VillagePSListBloc>(context).add(GetVillagePSList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(32),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.9,
        child: BlocBuilder<VillagePSListBloc, VillagePSListState>(
          builder: (context, state) {
            if (state is VillagePSListLoading) {
              return const Loading();
            }
            if (state is VillagePSListSuccess) {
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  spacer(),
                  buildDropButton(
                      value: _bloc.chosenType,
                      items: _bloc.types,
                      hint: CHOSE_TYPE,
                      onChanged: (String? value) {
                        setState(() {
                          _bloc.chosenType = value;
                        });
                      }),
                  spacer(),
                  villageSelectDropDown(
                      isPs: true,
                      list: getPSListInString(state.policeStations),
                      selValue: _bloc.psId,
                      onChanged: (value) {
                        _bloc.psId =
                            getPsIDFromPSName(state.policeStations, value!);
                      }),
                  spacer(),
                  villageSelectDropDown(
                      list: getVillageListInString(state.villages),
                      selValue: _bloc.ppId,
                      onChanged: (value) {
                        _bloc.ppId = getPpIDFromVillage(state.villages, value!);
                      }),
                  spacer(),
                  buildDateTextField(context, _fromController, DATE_FROM),
                  spacer(),
                  buildDateTextField(context, _toController, DATE_TO),
                  spacer(),
                  CustomButton(
                      text: APPLY_FILTER,
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<WatchRegisterBloc>(context).add(
                            GetWatchData(
                                type: _bloc.chosenType,
                                ppId: _bloc.ppId,
                                psId: _bloc.psId,
                                fromDate: _fromController.text,
                                toDate: _toController.text));
                      })
                ],
              );
            }
            if (state is VillagePSListFailed) {
              return SomethingWentWrong();
            } else {
              return SomethingWentWrong();
            }
          },
        ),
      ),
    );
  }
}

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
            showSnackBar(context, state.message);
          }
          if (state is WatchDataDeleted) {
            showSnackBar(context, state.message);
            BlocProvider.of<WatchRegisterBloc>(context).add(GetWatchData());
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
                            final watchData = state.watchResponse.data![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, watchData);
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
                                          watchData.type!,
                                          style: Styles.primaryTextStyle(),
                                        ),
                                        if (watchData.type! == "भटक्या टोळी")
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit_rounded,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  _navigateToRegister(context,
                                                      watchData: watchData);
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_rounded,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              WatchRegisterBloc>(
                                                          context)
                                                      .add(DeleteWatchData(
                                                          watchData.id!));
                                                },
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: NAME,
                                        value: watchData.name ?? "-"),
                                    HeadValueText(
                                        title: DESCRIPTION,
                                        value: watchData.description ?? "-"),
                                    HeadValueText(
                                        title: ADDRESS,
                                        value: watchData.address ?? "-"),
                                  ],
                                ),
                              ),
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
          _navigateToRegister(context);
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  _navigateToRegister(BuildContext context, {WatchData? watchData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return WatchRegFormScreen(
        watchData: watchData,
      );
    })).then((value) {
      BlocProvider.of<WatchRegisterBloc>(context).add(GetWatchData());
    });
  }

  _showDetails(BuildContext context, WatchData watchData) {
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

  String? chosenType, psId, ppId;
  final List<String> types = <String>[
    "सर्व",
    "भटक्या टोळी",
    "सराईत गुन्हेगार",
    "फरार आरोपी",
    "तडीपार आरोपी",
    "स्टॅंडिंग वॉरंट"
  ];

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
                      value: chosenType,
                      items: types,
                      hint: CHOSE_TYPE,
                      onChanged: (String? value) {
                        setState(() {
                          chosenType = value;
                        });
                      }),
                  spacer(),
                  villageSelectDropDown(
                      isPs: true,
                      list: getPSListInString(state.policeStations),
                      selValue: psId,
                      onChanged: (value) {
                        psId = getPsIDFromPSName(state.policeStations, value!);
                      }),
                  spacer(),
                  villageSelectDropDown(
                      list: getVillageListInString(state.villages),
                      selValue: ppId,
                      onChanged: (value) {
                        ppId = getPpIDFromVillage(state.villages, value!);
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
                                type: chosenType,
                                ppId: ppId,
                                psId: psId,
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

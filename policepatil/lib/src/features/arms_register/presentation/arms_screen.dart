import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/features/arms_register/presentation/arms_register.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/heading_value_text_widget.dart';
import '../bloc/arms_register_bloc.dart';
import '../models/arms_model.dart';

class ArmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(ARMS_COLLECTIONS),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToRegister(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ArmsRegisterBloc, ArmsRegisterState>(
        listener: (context, state) {
          if (state is ArmsLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
          if (state is ArmsDataChangeSuccess) {
            BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData());
            showSnackBar(context, 'Deleted Success.');
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<ArmsRegisterBloc>(context)
                          .add(GetArmsData());
                    },
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        physics: const BouncingScrollPhysics(),
                        child: ListView.builder(
                            itemCount: state.armsResponse.data.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final armsData = state.armsResponse.data[index];
                              return InkWell(
                                onTap: () {
                                  _showDetails(context, armsData);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: CONTAINER_BACKGROUND_COLOR),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            armsData.type!,
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
                                                      armsData: armsData);
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_rounded,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              ArmsRegisterBloc>(
                                                          context)
                                                      .add(DeleteArmsData(
                                                          armsData.id!));
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      HeadValueText(
                                          title: NAME,
                                          value: armsData.name ?? "-"),
                                      HeadValueText(
                                          title: MOB_NO,
                                          value: "${armsData.mobile ?? "-"} "),
                                      HeadValueText(
                                          title: ADDRESS,
                                          value: armsData.address ?? "-"),
                                      HeadValueText(
                                          title: "परवाना क्रमांक",
                                          value: armsData.licenceNumber ?? "-"),
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ),
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
    );
  }

  _navigateToRegister(BuildContext context, {ArmsData? armsData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ArmsRegFormScreen(armsData: armsData);
    })).then((value) =>
        BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData()));
    // whenComplete(
    //     () => BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData()));
  }

  _showDetails(BuildContext context, ArmsData armsData) {
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
                  HeadValueText(title: NAME, value: armsData.name ?? "-"),
                  HeadValueText(
                      title: MOB_NO, value: "${armsData.mobile ?? "-"} "),
                  HeadValueText(title: ADDRESS, value: armsData.address ?? "-"),
                  HeadValueText(
                      title: "परवाना क्रमांक",
                      value: armsData.licenceNumber ?? "-"),
                  HeadValueText(
                      title: "परवान्याची वैधता कालावधी",
                      value: dateInStringFormat(armsData.validity)),
                  spacer(height: 8),
                  if (armsData.aadhar != null)
                    Text(
                      AADHAR,
                      style: Styles.titleTextStyle(),
                    ),
                  if (armsData.aadhar != null)
                    CachedNetworkImage(
                      imageUrl: "http://${armsData.aadhar}",
                      width: 300,
                    ),
                  spacer(height: 8),
                  if (armsData.licencephoto != null)
                    Text(
                      "परवान्याचा फोटो",
                      style: Styles.titleTextStyle(),
                    ),
                  if (armsData.licencephoto != null)
                    CachedNetworkImage(
                      imageUrl: "http://${armsData.licencephoto}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

//
// class ArmsDetailWidget extends StatelessWidget {
//   const ArmsDetailWidget({Key? key, required this.armsData}) : super(key: key);
//   final ArmsData armsData;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         _showDetails(context);
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: CONTAINER_BACKGROUND_COLOR),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   armsData.type!,
//                   style: Styles.primaryTextStyle(),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.edit_rounded,
//                         size: 20,
//                       ),
//                       onPressed: () {
//                         // _navigateToRegister(context, armsData: armsData);
//                         Navigator.push(context, MaterialPageRoute(builder: (_) {
//                           return ArmsRegFormScreen(
//                             armsData: armsData,
//                           );
//                         })).then((value) {
//                           BlocProvider.of<ArmsRegisterBloc>(context)
//                               .add(GetArmsData());
//                         });
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.delete_rounded,
//                         size: 20,
//                       ),
//                       onPressed: () {
//                         BlocProvider.of<ArmsRegisterBloc>(context)
//                             .add(DeleteArmsData(armsData.id!));
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             const Divider(),
//             HeadValueText(title: NAME, value: armsData.name ?? "-"),
//             HeadValueText(title: MOB_NO, value: "${armsData.mobile ?? "-"} "),
//             HeadValueText(title: ADDRESS, value: armsData.address ?? "-"),
//             HeadValueText(
//                 title: "परवाना क्रमांक", value: armsData.licenceNumber ?? "-"),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }

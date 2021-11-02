import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/screens/register/collect_register.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CollectRegisterBloc>(context).add(GetCollectionData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(COLLECTION_REGISTER),
      ),
      body: BlocListener<CollectRegisterBloc, CollectRegisterState>(
        listener: (context, state) {
          if (state is CollectionLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<CollectRegisterBloc, CollectRegisterState>(
          builder: (context, state) {
            if (state is CollectionDataLoading) {
              return const Loading();
            } else if (state is CollectionDataLoaded) {
              if (state.collectionResponse.collectData!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount:
                              state.collectionResponse.collectData!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CollectionDetailWidget(
                              collect:
                                  state.collectionResponse.collectData![index],
                            );
                          })),
                );
              }
            } else if (state is CollectionLoadError) {
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
            return const CollectRegFormScreen();
          })).then((value) {
            BlocProvider.of<CollectRegisterBloc>(context)
                .add(GetCollectionData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class CollectionDetailWidget extends StatelessWidget {
  const CollectionDetailWidget({Key? key, required this.collect})
      : super(key: key);
  final CollectionData collect;

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
            Text(collect.type!, style: Styles.primaryTextStyle()),
            const Divider(),
            HeadValueText(
                title: DESCRIPTION, value: collect.description ?? "-"),
            HeadValueText(title: ADDRESS, value: collect.address ?? "-"),
            HeadValueText(title: DATE, value: showDate(collect.date!)),
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
                  Text(collect.type!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(
                      title: DESCRIPTION, value: collect.description ?? "-"),
                  HeadValueText(title: ADDRESS, value: collect.address ?? "-"),
                  HeadValueText(title: DATE, value: showDate(collect.date!)),
                  spacer(height: 8),
                  if (collect.photo != null)
                    Text(
                      PHOTO,
                      style: Styles.titleTextStyle(),
                    ),
                  if (collect.photo != null)
                    CachedNetworkImage(
                      imageUrl: "http://${collect.photo}",
                      width: 300,
                    ),
                ],
              ),
            ),
          );
        });
  }
}

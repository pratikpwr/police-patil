import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/file_picker_helper.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/attach_button.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../../../core/views/widgets/custom_date_textfield.dart';
import '../../../core/views/widgets/custom_dropdown.dart';
import '../../../core/views/widgets/custom_textfield.dart';
import '../../../core/views/widgets/heading_value_text_widget.dart';
import '../bloc/collect_register_bloc.dart';
import '../models/collect_model.dart';
import 'collect_register.dart';

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
          if (state is CollectionDataDeleted) {
            BlocProvider.of<CollectRegisterBloc>(context)
                .add(GetCollectionData());
            showSnackBar(context, DELETED);
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
                            final collect =
                                state.collectionResponse.collectData![index];
                            return InkWell(
                              onTap: () {
                                _showDetails(context, collect);
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
                                          collect.type!,
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
                                                    collect: collect);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            CollectRegisterBloc>(
                                                        context)
                                                    .add(DeleteCollectionData(
                                                        collect.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: DESCRIPTION,
                                        value: collect.description ?? "-"),
                                    HeadValueText(
                                        title: ADDRESS,
                                        value: collect.address ?? "-"),
                                    HeadValueText(
                                        title: DATE,
                                        value: showDate(collect.date!)),
                                  ],
                                ),
                              ),
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
          _navigateToRegister(context);
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  _navigateToRegister(BuildContext context, {CollectionData? collect}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CollectRegFormScreen(
        collect: collect,
      );
    })).then((value) =>
        BlocProvider.of<CollectRegisterBloc>(context).add(GetCollectionData()));
    // whenComplete(
    //     () => BlocProvider.of<ArmsRegisterBloc>(context).add(GetArmsData()));
  }

  _showDetails(BuildContext context, CollectionData collect) {
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

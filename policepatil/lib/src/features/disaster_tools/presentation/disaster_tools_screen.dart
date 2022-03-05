import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../bloc/disaster_tools_bloc.dart';
import '../models/tools_model.dart';
import 'disaster_tools_register.dart';

class DisasterManageToolsScreen extends StatelessWidget {
  const DisasterManageToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisasterToolsBloc>(context).add(GetToolsData());
    return Scaffold(
      appBar: AppBar(title: const Text(DISASTER_TOOLS)),
      body: BlocListener<DisasterToolsBloc, DisasterToolsState>(
        listener: (context, state) {
          if (state is ToolsLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<DisasterToolsBloc, DisasterToolsState>(
          builder: (context, state) {
            if (state is ToolsDataLoading) {
              return const Loading();
            } else if (state is ToolsDataLoaded) {
              if (state.toolsResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.toolsResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ToolsDetailWidget(
                              helperData: state.toolsResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is ToolsLoadError) {
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
            return const DisasterToolsRegisterForm();
          })).then((value) {
            BlocProvider.of<DisasterToolsBloc>(context).add(GetToolsData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class ToolsDetailWidget extends StatelessWidget {
  const ToolsDetailWidget({Key? key, required this.helperData})
      : super(key: key);
  final ToolsData helperData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              helperData.name!,
              style: Styles.primaryTextStyle(),
            ),
            const Divider(),
            Text(
              helperData.quantity!.toString(),
              style: Styles.subTitleTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

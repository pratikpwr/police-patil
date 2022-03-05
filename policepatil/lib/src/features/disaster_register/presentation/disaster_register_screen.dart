import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../bloc/disaster_register_bloc.dart';
import '../models/disaster_model.dart';
import 'disaster_register.dart';

class DisasterRegScreen extends StatelessWidget {
  const DisasterRegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisasterRegisterBloc>(context).add(GetDisasterData());
    return Scaffold(
      appBar: AppBar(title: const Text(REGISTER_DISASTER)),
      body: BlocListener<DisasterRegisterBloc, DisasterRegisterState>(
        listener: (context, state) {
          if (state is DisasterLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<DisasterRegisterBloc, DisasterRegisterState>(
          builder: (context, state) {
            if (state is DisasterDataLoading) {
              return const Loading();
            } else if (state is DisasterDataLoaded) {
              if (state.disasterResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.disasterResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DisasterDetailWidget(
                              disasterData: state.disasterResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is DisasterLoadError) {
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
            return const DisasterRegFormScreen();
          })).then((value) {
            BlocProvider.of<DisasterRegisterBloc>(context)
                .add(GetDisasterData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class DisasterDetailWidget extends StatelessWidget {
  const DisasterDetailWidget({Key? key, required this.disasterData})
      : super(key: key);
  final DisasterData disasterData;

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
              disasterData.type!,
              style: Styles.primaryTextStyle(),
            ),
            Text(
              disasterData.subtype!,
              style: Styles.subTitleTextStyle(),
            ),
            const Divider(),
            Text(
              disasterData.date!.toIso8601String().substring(0, 10),
              style: Styles.subTitleTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/heading_value_text_widget.dart';
import '../bloc/crime_register_bloc.dart';
import '../models/crime_model.dart';
import 'crimes_register_screen.dart';

class CrimesScreen extends StatelessWidget {
  const CrimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CrimeRegisterBloc>(context).add(GetCrimeData());
    return Scaffold(
      appBar: AppBar(
        title: const Text(CRIMES),
      ),
      body: BlocListener<CrimeRegisterBloc, CrimeRegisterState>(
        listener: (context, state) {
          if (state is CrimeLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
          if (state is CrimeDataDeleted) {
            showSnackBar(context, DELETED);
            BlocProvider.of<CrimeRegisterBloc>(context).add(GetCrimeData());
          }
        },
        child: BlocBuilder<CrimeRegisterBloc, CrimeRegisterState>(
          builder: (context, state) {
            if (state is CrimeDataLoading) {
              return const Loading();
            } else if (state is CrimeDataLoaded) {
              if (state.crimeResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.crimeResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final crimesData = state.crimeResponse.data![index];
                            return InkWell(
                              onTap: () {},
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
                                          crimesData.type!,
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
                                                    crimesData: crimesData);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            CrimeRegisterBloc>(
                                                        context)
                                                    .add(DeleteCrimeData(
                                                        crimesData.id!));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    HeadValueText(
                                        title: "गुन्हा रजिस्टर नंबर",
                                        value:
                                            crimesData.registerNumber ?? "-"),
                                    HeadValueText(
                                        title: DATE,
                                        value: showDate(crimesData.date!)),
                                  ],
                                ),
                              ),
                            );
                          })),
                );
              }
            } else if (state is CrimeLoadError) {
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

  _navigateToRegister(BuildContext context, {CrimeData? crimesData}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CrimeRegFormScreen(crimesData: crimesData);
    })).then((value) {
      BlocProvider.of<CrimeRegisterBloc>(context).add(GetCrimeData());
    });
  }
}

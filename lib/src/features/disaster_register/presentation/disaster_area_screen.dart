import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../bloc/disaster_register_bloc.dart';
import 'disaster_area_add_screen.dart';

class DisasterAreaScreen extends StatelessWidget {
  const DisasterAreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisasterRegisterBloc>(context).add(GetDisasterArea());
    return Scaffold(
      appBar: AppBar(title: const Text("आपत्ती प्रवण क्षेत्र")),
      body: BlocListener<DisasterRegisterBloc, DisasterRegisterState>(
        listener: (context, state) {
          if (state is DisasterLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<DisasterRegisterBloc, DisasterRegisterState>(
          builder: (context, state) {
            if (state is DisasterAreaLoading) {
              return const Loading();
            } else if (state is DisasterAreaLoaded) {
              if (state.areas.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.areas.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DisasterAreaDetailWidget(
                              area: state.areas[index],
                            );
                          })),
                );
              }
            } else if (state is DisasterAreaLoadError) {
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
            return const DisasterAreaAddForm();
          })).then((value) {
            BlocProvider.of<DisasterRegisterBloc>(context)
                .add(GetDisasterArea());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class DisasterAreaDetailWidget extends StatelessWidget {
  const DisasterAreaDetailWidget({Key? key, required this.area})
      : super(key: key);
  final String area;

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
              area,
              style: Styles.primaryTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

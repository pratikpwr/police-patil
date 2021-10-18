import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          ILLEGAL_WORKS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<IllegalRegisterBloc, IllegalRegisterState>(
        listener: (context, state) {
          if (state is IllegalLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<IllegalRegisterBloc, IllegalRegisterState>(
          builder: (context, state) {
            if (state is IllegalDataLoading) {
              return Loading();
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
                            return IllegalDetailWidget(
                              illegalData: state.illegalResponse.data![index],
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
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const IllegalWorksFormScreen();
          })).then((value) {
            BlocProvider.of<IllegalRegisterBloc>(context).add(GetIllegalData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class IllegalDetailWidget extends StatelessWidget {
  const IllegalDetailWidget({Key? key, required this.illegalData})
      : super(key: key);
  final IllegalData illegalData;

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
            color: GREY_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(illegalData.type!, style: Styles.primaryTextStyle()),
            const Divider(),
            HeadValueText(title: NAME, value: "${illegalData.name}"),
            HeadValueText(title: ADDRESS, value: "${illegalData.address}"),
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
                  Text(illegalData.type!, style: Styles.primaryTextStyle()),
                  const Divider(),
                  spacer(height: 8),
                  HeadValueText(title: NAME, value: "${illegalData.name}"),
                  HeadValueText(
                      title: ADDRESS, value: "${illegalData.address}"),
                  spacer(height: 8),
                  Text(
                    PHOTO,
                    style: Styles.titleTextStyle(),
                  ),
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

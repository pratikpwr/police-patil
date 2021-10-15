import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/screens/register/illegal_works_register.dart';
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
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: GREY_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              illegalData.type!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              illegalData.name!,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Text(
              illegalData.address!,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

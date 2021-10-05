import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class SocialPlaceScreen extends StatelessWidget {
  const SocialPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PublicPlaceRegisterBloc>(context).add(GetPublicPlaceData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SOCIAL_PLACES,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
        listener: (context, state) {
          if (state is PublicPlaceLoadError) {
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
          builder: (context, state) {
            if (state is PublicPlaceDataLoading) {
              return loading();
            } else if (state is PublicPlaceDataLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.placeResponse.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PlaceDetailWidget(
                            placeData: state.placeResponse.data![index],
                          );
                        })),
              );
            } else if (state is PublicPlaceLoadError) {
              if (state.message == 'Record Empty') {
                return noRecordFound();
              } else {
                return somethingWentWrong();
              }
            } else {
              return somethingWentWrong();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const SocialPlacesRegFormScreen();
          })).then((value) {
            BlocProvider.of<PublicPlaceRegisterBloc>(context)
                .add(GetPublicPlaceData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class PlaceDetailWidget extends StatelessWidget {
  const PlaceDetailWidget({Key? key, required this.placeData})
      : super(key: key);
  final PlaceData placeData;

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
              placeData.place!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              placeData.address!,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

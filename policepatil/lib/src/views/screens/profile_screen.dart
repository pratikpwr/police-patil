import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/modules/authentication/auth.dart';
import 'package:shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(GetUserData());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            PROFILE,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoadError) {
              showSnackBar(context, state.error);
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return loading();
              } else if (state is ProfileDataLoaded) {
                return SafeArea(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: state.user.photo,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  spacer(),
                                  Text(
                                    state.user.name,
                                    style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    state.user.village,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            spacer(height: 20),
                            // buildDetailsRow(Icons.perm_identity, "y585858"),
                            // spacer(height: 8  ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDetails(
                                    "मो. नंबर :", state.user.mobile.toString()),
                                spacer(height: 12),
                                buildDetails("पत्ता :", state.user.address),
                                spacer(height: 12),
                                buildDetails(
                                    "नेमणुकीची तारीख :",
                                    state.user.joindate
                                        .toIso8601String()
                                        .substring(0, 10)),
                                spacer(height: 12),
                                buildDetails(
                                    "नेमणुकीची मुदत :",
                                    state.user.enddate
                                        .toIso8601String()
                                        .substring(0, 10)),
                                spacer(height: 12),
                                buildDetails("पो. ठा. पासून गावाचे अंतर :",
                                    "${state.user.psdistance} कि.मी."),
                                spacer(),
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              } else if (state is ProfileLoadError) {
                return somethingWentWrong();
              }
              return somethingWentWrong();
            },
          ),
        ),
      ),
    );
  }

  _logout(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "लॉग आऊट करायचे ?",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(UserLogOut());
                    Navigator.pushReplacementNamed(context, '/auth');
                  },
                  child: Text(
                    YES,
                    style: GoogleFonts.poppins(fontSize: 15),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    NO,
                    style: GoogleFonts.poppins(fontSize: 15),
                  ))
            ],
          );
        });
  }

  Widget buildDetails(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600)),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        )
      ],
    );
  }

  Widget buildDetailsRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}

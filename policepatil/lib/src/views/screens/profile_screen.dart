import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
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
          title: const Text(PROFILE),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: const Icon(
                  Icons.logout,
                ))
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
                return const Loading();
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
                                      imageUrl: "http://${state.user.photo}",
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  spacer(),
                                  Text(
                                    state.user.name ?? "-",
                                    style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    state.user.village ?? "-",
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
                                buildDetails("??????. ???????????? :",
                                    "${state.user.mobile ?? "-"}"),
                                spacer(height: 12),
                                buildDetails(
                                    "??????????????? :", state.user.address ?? "-"),
                                spacer(height: 12),
                                buildDetails(
                                    "???????????? ?????????.", state.user.orderNo ?? "-"),
                                spacer(),
                                buildDetails(
                                    "??????????????????????????? ??????????????? :",
                                    state.user.joindate == null
                                        ? "-"
                                        : showDate(state.user.joindate!)),
                                spacer(height: 12),
                                buildDetails(
                                    "??????????????????????????? ???????????? :",
                                    state.user.enddate == null
                                        ? "-"
                                        : showDate(state.user.enddate!)),
                                spacer(height: 12),
                                buildDetails("??????. ??????. ??????????????? ?????????????????? ???????????? :",
                                    "${state.user.psdistance ?? "-"} ??????.??????."),
                                spacer(),
                              ],
                            ),
                            Center(
                              child: CustomButton(
                                  text: "?????????????????? ??????????????? ?????????",
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return UpdateProfile(
                                        user: state.user,
                                      );
                                    })).then((_) {
                                      BlocProvider.of<ProfileBloc>(context)
                                          .add(GetUserData());
                                    });
                                  }),
                            )
                          ],
                        ),
                      )),
                );
              } else if (state is ProfileLoadError) {
                return SomethingWentWrong();
              }
              return SomethingWentWrong();
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
              "????????? ????????? ?????????????????? ?",
              style: Styles.titleTextStyle(),
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
                    style: Styles.textButtonTextStyle(),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    NO,
                    style: Styles.textButtonTextStyle(),
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

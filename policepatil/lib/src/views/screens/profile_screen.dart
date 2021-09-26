import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/modules/authentication/auth.dart';
import 'package:shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // late ProfileBloc _profileBloc;
  //
  // @override
  // void initState() {
  //   _profileBloc = ProfileBlocController().profileBloc;
  //   _profileBloc.add(GetUserData());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(GetUserData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          PROFILE,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(UserLogOut());
                Navigator.pushReplacementNamed(context, '/auth');
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileDataLoaded) {
              print('heelloo');
              return SafeArea(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              state.user.photo,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          spacer(),
                          Text(
                            state.user.name,
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            state.user.village,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          spacer(height: 20),
                          // buildDetailsRow(Icons.perm_identity, "y585858"),
                          // spacer(height: 8  ),
                          buildDetails(
                              "मो. नंबर :", state.user.mobile.toString()),
                          spacer(height: 8),
                          buildDetails("पत्ता :", state.user.address),
                          spacer(height: 8),
                          buildDetails("नेमणुकीची तारीख :",
                              state.user.joindate.toIso8601String()),
                          spacer(height: 8),
                          buildDetails("नेमणुकीची मुदत :",
                              state.user.enddate.toIso8601String()),
                          spacer(height: 8),
                          buildDetails("पो. ठा. पासून गावाचे अंतर :",
                              "${state.user.psdistance} कि.मी."),
                          spacer(),
                        ],
                      ),
                    )),
              );
            } else if (state is ProfileLoadError) {
              return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildDetails(String title, String text) {
    return Row(
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600)),
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

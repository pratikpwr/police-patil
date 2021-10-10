import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/screens/kayade_screen.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            POLICE_PATIL_APP,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          // ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              spacer(height: 8),
              BlocProvider(
                  create: (context) => NewsBloc(),
                  child: const ImpNewsWidget()),
              spacer(),
              RegistersButton(
                  text: REGISTER,
                  imageUrl: ImageConstants.IMG_PLACEHOLDER,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const RegisterMenuScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: MANDHAN,
                  imageUrl: ImageConstants.IMG_MONEY,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const MandhanScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: LAWS,
                  imageUrl: ImageConstants.IMG_HAMMER,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const KayadeScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: DISASTER_MANAGEMENT,
                  imageUrl: ImageConstants.IMG_DISASTER,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const DisasterMenuScreen();
                    }));
                  }),
            ],
          ),
        )));
  }
}

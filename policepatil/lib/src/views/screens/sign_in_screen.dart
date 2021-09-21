import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:shared/modules/auth/bloc/auth_bloc.dart';

import '../views.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
          }
          if (state is AuthSuccess) {
            isLoading = false;
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (ctx) {
              return const BottomNavBar();
            }));
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : signInWidget()),
        )),
      ),
    );
  }

  Widget signInWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const LogoWidget(),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: _emailController,
          style: GoogleFonts.poppins(fontSize: 14),
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email_rounded,
              ),
              hintText: USER_ID,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: _passwordController,
          style: GoogleFonts.poppins(fontSize: 14),
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_rounded,
              ),
              hintText: PASSWORD,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
        const SizedBox(
          height: 16,
        ),
        _authButton(
            text: SIGN_IN,
            onTap: () {
              // if (_emailController.text.length < 6) {
              //   return showSnackBar(context, 'Enter valid userId!');
              // }
              // if (_passwordController.text.length < 6) {
              //   return showSnackBar(context, 'Password is too short!');
              // }
              BlocProvider.of<AuthBloc>(context).add(SignInEvent(
                  email: _emailController.text,
                  password: _passwordController.text));
            }),
      ],
    );
  }

  Widget _authButton({required String text, required VoidCallback onTap}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
            primary: const Color(0xff000eac),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
        ));
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../views.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = AuthenticationBlocController().authenticationBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showError(String error) async {
      await Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              debugPrint(state.message);
              _showError(state.message);
            } else if (state is AppAuthenticated) {
              if (kIsWeb) {
                Navigator.pushReplacementNamed(context, '/admin');
              } else {
                Navigator.pushReplacementNamed(context, '/bottomNavBar');
              }
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              return SafeArea(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SignInWidget(
                    authenticationBloc: authenticationBloc, state: state),
              ));
            },
          ),
        ),
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  SignInWidget(
      {Key? key, required this.authenticationBloc, required this.state})
      : super(key: key);
  final AuthenticationBloc authenticationBloc;
  final AuthenticationState state;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: _size.height,
        color: Colors.white,
        width: _size.width < 450 ? _size.width : 450,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(logoSize: 240),
              spacer(height: 24),
              TextFormField(
                decoration: InputDecoration(
                    labelText: USER_ID,
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                controller: _emailController,
                style: GoogleFonts.poppins(fontSize: 14),
                autocorrect: false,
                validator: (value) {
                  if (value == "") {
                    return 'युजर आयडी टाका!';
                  }
                  return null;
                },
              ),
              spacer(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: PASSWORD,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  isDense: true,
                ),
                style: GoogleFonts.poppins(fontSize: 14),
                controller: _passwordController,
                validator: (value) {
                  if (value == "") {
                    return 'पासवर्ड टाका!';
                  } else if (value!.length < 6) {
                    return 'पासवर्ड लहान आहे!';
                  }
                  return null;
                },
              ),
              spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                      primary: const Color(0xff000eac),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      authenticationBloc.add(UserLogin(
                          email: _emailController.text,
                          password: _passwordController.text));
                    }
                  },
                  child: state is AuthenticationLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          SIGN_IN,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 18),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

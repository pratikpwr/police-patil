import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../views.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              debugPrint(state.message);
              showSnackBar(context, state.message);
            }
            if (state is AppAuthenticated) {
              Navigator.pushReplacementNamed(context, '/bottomNavBar');
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              Size _size = MediaQuery.of(context).size;
              return SafeArea(
                  child: SingleChildScrollView(
                      child: Stack(
                children: [
                  Image.asset(
                    ImageConstants.IMG_SHAPES_3,
                    height: _size.height,
                    width: _size.width,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height: _size.height * 0.82,
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
                            cursorColor: PRIMARY_COLOR,
                            decoration: InputDecoration(
                              labelText: USER_ID,
                              labelStyle: Styles.inputFieldTextStyle(),
                              filled: true,
                              isDense: true,
                            ),
                            controller: _emailController,
                            style: Styles.inputFieldTextStyle(),
                            autocorrect: false,
                            validator: (value) {
                              if (value == "") {
                                return '???????????? ???????????? ????????????!';
                              }
                              return null;
                            },
                          ),
                          spacer(height: 12),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: PASSWORD,
                              labelStyle: Styles.inputFieldTextStyle(),
                              filled: true,
                              isDense: true,
                            ),
                            style: Styles.inputFieldTextStyle(),
                            controller: _passwordController,
                            validator: (value) {
                              if (value == "") {
                                return '????????????????????? ????????????!';
                              } else if (value!.length < 6) {
                                return '????????????????????? ???????????? ?????????!';
                              }
                              return null;
                            },
                          ),
                          spacer(),
                          state is AuthenticationLoading
                              ? const Loading()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 32),
                                      primary: ORANGE,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(UserLogin(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text));
                                    }
                                  },
                                  child: Text(SIGN_IN,
                                      style: Styles.buttonTextStyle()),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              )));
            },
          ),
        ),
      ),
    );
  }
}

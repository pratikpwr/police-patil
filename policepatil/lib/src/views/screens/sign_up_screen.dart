// import 'package:flutter/material.dart';
// import 'package:nearme/config/constants.dart';
// import 'package:nearme/utils/utils.dart';
//
// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     final titleView = Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Visibility(
//           visible: Navigator.of(context).canPop(),
//           maintainSize: true,
//           maintainAnimation: true,
//           maintainState: true,
//           child: IconButton(
//               padding: EdgeInsets.zero,
//               iconSize: 30,
//               icon: Icon(
//                 Icons.clear,
//                 color: Colors.grey,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               }),
//         ),
//         Text(
//           'Create your account',
//           style: TextStyle(
//               fontFamily: 'Montserrat',
//               fontSize: 16,
//               fontWeight: FontWeight.w600),
//         ),
//         SizedBox(
//           width: 36,
//         )
//       ],
//     );
//
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             width: Utils.getScreenWidth(screenSize),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: titleView,
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 22.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Image.asset(
//                                 'assets/near_me.webp',
//                                 height: 100,
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 16, bottom: 10),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(3),
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(15, 8, 15, 8),
//                                     child: TextField(
//                                       autofocus: false,
//                                       onChanged: (value) {
//                                         _bloc.signUpRequest.fullName = value;
//                                       },
//                                       style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           fontSize: 16,
//                                           color: Colors.black87),
//                                       decoration: InputDecoration(
//                                           hintText: FULL_NAME,
//                                           border: InputBorder.none),
//                                     ),
//                                   ),
//                                   Divider(
//                                     color: Colors.grey,
//                                     height: 1,
//                                   ),
//                                   Container(
//                                     height: 45,
//                                     margin:
//                                         const EdgeInsets.fromLTRB(0, 8, 15, 8),
//                                     child: TextField(
//                                       onChanged: (value) {
//                                         _bloc.signUpRequest.mobile = value;
//                                       },
//                                       keyboardType: TextInputType.phone,
//                                       maxLength: 10,
//                                       autofocus: false,
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black87,
//                                           fontFamily: 'Montserrat'),
//                                       decoration: InputDecoration(
//                                           counterText: "",
//                                           prefixIcon: Container(
//                                             child: Text(
//                                               '+91',
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Colors.black87,
//                                                   fontFamily: 'Montserrat'),
//                                             ),
//                                             alignment: Alignment.center,
//                                             width: double.minPositive,
//                                             height: double.minPositive,
//                                           ),
//                                           hintText: MOBILE,
//                                           border: InputBorder.none),
//                                     ),
//                                   ),
//                                   Divider(
//                                     color: Colors.grey,
//                                     height: 1,
//                                   ),
//                                   Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           15, 8, 0, 8),
//                                       child: StreamBuilder(
//                                           stream: _bloc.obscureStream,
//                                           initialData: true,
//                                           builder: (BuildContext context,
//                                               AsyncSnapshot<bool> snapshot) {
//                                             return TextField(
//                                               onChanged: (value) {
//                                                 _bloc.signUpRequest.password =
//                                                     value;
//                                               },
//                                               autofocus: false,
//                                               obscureText: snapshot.data,
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Colors.black87,
//                                                   fontFamily: 'Montserrat'),
//                                               decoration: InputDecoration(
//                                                 hintText: PASSWORD,
//                                                 suffixIcon: SizedBox(
//                                                   width: 68,
//                                                   child: FlatButton(
//                                                     padding: EdgeInsets.all(0),
//                                                     onPressed: () {
//                                                       _bloc.onObscure(
//                                                           _bloc.isObscure);
//                                                     },
//                                                     child: Text(
//                                                       _bloc.isObscure
//                                                           ? 'Show'
//                                                           : 'Hide',
//                                                       style: TextStyle(
//                                                           fontSize: 12,
//                                                           fontFamily:
//                                                               'Montserrat'),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 border: InputBorder.none,
//                                               ),
//                                             );
//                                           }))
//                                 ],
//                               ),
//                             ),
//                             FlatButton(
//                               onPressed: () {
//                                 setState(() {});
//                               },
//                               child: RichText(
//                                 text: TextSpan(
//                                   style: TextStyle(
//                                     fontFamily: 'Montserrat',
//                                     fontSize: 10,
//                                     color: Colors.grey,
//                                   ),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                         text:
//                                             'By signing up you agree with our '),
//                                     TextSpan(
//                                         text: 'Terms & Conditions',
//                                         style: TextStyle(
//                                             fontFamily: 'Montserrat',
//                                             decoration:
//                                                 TextDecoration.underline)),
//                                   ],
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(height: 15.0),
//                             StreamBuilder<bool>(
//                                 stream: _bloc.progressStream,
//                                 initialData: false,
//                                 builder: (BuildContext context,
//                                     AsyncSnapshot<bool> snapShot) {
//                                   return RaisedButton(
//                                     padding: EdgeInsets.all(15),
//                                     textColor: Colors.white,
//                                     color: PRIMARY_COLOR,
//                                     onPressed: () {
//                                       _bloc.doSendOTP();
//                                     },
//                                     child: snapShot.data
//                                         ? ButtonIndicator(size: 22)
//                                         : Text(GET_OTP,
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontFamily: 'Montserrat')),
//                                   );
//                                 }),
//                             SizedBox(height: 30),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Text(
//                                   'Used NearMe before?',
//                                   style: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 InkWell(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10, horizontal: 3),
//                                     child: Text(
//                                       'Login',
//                                       style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           fontSize: 14,
//                                           color: PRIMARY_COLOR,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     if (Navigator.of(context).canPop())
//                                       Navigator.of(context).pop();
//                                     else {
//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => LoginPage(
//                                                   title: LOGIN,
//                                                 )),
//                                       );
//                                     }
//                                   },
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 16,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

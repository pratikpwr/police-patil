// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:policepatil/src/config/constants.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
  )));
}

Future<List<dynamic>> getFileFromDevice(
    BuildContext context, String title) async {
  File? _fileImage;
  final picker = ImagePicker();
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'फोटो काढा अथवा गॅलरी मधून निवडा',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  final pickedImage =
                      await picker.pickImage(source: ImageSource.camera);

                  if (pickedImage != null) {
                    title = pickedImage.name;
                    _fileImage = File(pickedImage.path);
                  } else {
                    debugPrint('No image selected.');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'कॅमेरा',
                  style: GoogleFonts.poppins(fontSize: 14),
                )),
            TextButton(
                onPressed: () async {
                  final pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedImage != null) {
                    title = pickedImage.name;
                    _fileImage = File(pickedImage.path);
                  } else {
                    debugPrint('No image selected.');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'गॅलरी',
                  style: GoogleFonts.poppins(fontSize: 14),
                ))
          ],
        );
      });
  return [title, _fileImage];
}

String? youtubeUrlToId(String? url, {bool trimWhitespaces = true}) {
  if (!url!.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  SomethingWentWrong({Key? key, this.message}) : super(key: key);
  String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? SOMETHING_WENT_WRONG,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class NoRecordFound extends StatelessWidget {
  NoRecordFound({Key? key, this.message}) : super(key: key);
  String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? NO_RECORD,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

Widget spacer({double? height}) {
  return SizedBox(
    height: height ?? 16,
  );
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

void launchUrl(String url) async {
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

String dateInFormat(DateTime dateTime) {
  String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  String time = "${dateTime.hour}:${dateTime.minute}";
  return "वेळ: $time आणि तारीख: $date";
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/utils/styles.dart';
import 'package:shared/modules/village_ps_list/village_ps_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:policepatil/src/config/constants.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
    style: Styles.subTitleTextStyle(fontSize: 12),
  )));
}

String showDate(DateTime date) {
  return date.toIso8601String().substring(0, 10);
}

int? parseInt(String? string) {
  int? parsedInt;
  try {
    parsedInt = int.parse(string!);
    return parsedInt;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

DateTime? parseDate(String? date, {String? form}) {
  DateTime? formattedDate;
  DateFormat format = DateFormat(form ?? "yyyy-MM-dd");
  try {
    formattedDate = format.parse(date!);
    return formattedDate;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
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
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(PRIMARY_COLOR)),
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
  bool canLaunchUrl = await canLaunch(url);
  await launch(url);
}

String dateInStringFormat(DateTime? dateTime) {
  if (dateTime == null) {
    return "-";
  }
  String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  String time = "${dateTime.hour}:${dateTime.minute}";
  return "?????????: $time ????????? ???????????????: $date";
}

String dateInYYYYMMDDFormat(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  return date;
}

List<String> getVillageListInString(List<Village> list) {
  List<String> villageList = [];
  for (var vil in list) {
    villageList.add(vil.village!);
  }
  return villageList;
}

List<String> getPSListInString(List<PoliceStation> list) {
  List<String> villageList = [];
  for (var vil in list) {
    villageList.add(vil.psname!);
  }
  return villageList;
}

String getPsIDFromPSName(List<PoliceStation> psList, String psname) {
  var curVil = psList.firstWhere((element) => element.psname == psname);

  return curVil.id!.toString();
}

String getPpIDFromVillage(List<Village> vilList, String village) {
  var curVil = vilList.firstWhere((element) => element.village == village);

  return curVil.ppid!.toString();
}

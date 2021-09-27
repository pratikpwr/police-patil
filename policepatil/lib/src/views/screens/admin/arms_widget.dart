import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/responsive.dart';
import 'package:shared/shared.dart';

class ArmsWidget extends StatefulWidget {
  const ArmsWidget({Key? key}) : super(key: key);

  @override
  State<ArmsWidget> createState() => _ArmsWidgetState();
}

class _ArmsWidgetState extends State<ArmsWidget> {
  ArmsResponse? armsResponse;
  bool isLoading = true;

  getArmsData() async {
    try {
      Response response = await ApiSdk.getArms();
      armsResponse = ArmsResponse.fromJson(response.data);
      isLoading = false;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Responsive.isDesktop(context)
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        ImageConstants.IMG_ARMS,
                        height: 60,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        ARMS_COLLECTIONS,
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                isLoading
                    ? ListView.builder(
                        itemCount: armsResponse!.data.length,
                        itemBuilder: (context, index) {
                          return buildSmallDetail(armsResponse!.data[index]);
                        })
                    : const Center(child: CircularProgressIndicator())
              ],
            )
          : Column(),
    );
  }

  Widget buildSmallDetail(ArmsData arms) {
    return Row(
      children: [
        Text(
          "${arms.type}",
          style: GoogleFonts.poppins(fontSize: 28),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

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
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              spacer(height: 8),
              Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.UPDATES,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "महत्त्वाच्या घडामोडी !",
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      spacer(height: 8),
                      updates(context),
                    ],
                  )),
              spacer(),
              RegistersButton(
                  text: REGISTER,
                  imageUrl: ImageConstants.IMG_PLACEHOLDER,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const RegisterScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: "हजेरीबाबतचे स्वयंघोषणापत्र",
                  imageUrl: ImageConstants.IMG_CERTIFICATE,
                  onTap: () {}),
              spacer(),
              RegistersButton(
                  text: "पो. पाटलांनी घेतलेल्या बैठकी",
                  imageUrl: ImageConstants.IMG_MEETING,
                  onTap: () {}),
              spacer(),
            ],
          ),
        )));
  }

  Widget updates(BuildContext context) {
    var ups = [
      "जप्ती मालाचा प्रकार बेवारस वाहने दागिने गौण खनिज इतर, जप्ती मालाचा प्रकार बेवारस वाहने दागिने गौण खनिज इतर.",
      "हे हस्तलिखित प्रिंटिंग होणार हातासो ते लिहावे असे आवाहन  करतो व ते आपल्या फोटोसह माझ्या नावाने किंवा शाळेच्या नावाने पोस्टाने किंवा कुरिअर ने पाठवाव्यात",
      "अवैद्य दारू विक्री करणारे गुटका जुगार मटका चालविणारे इतर जुगार खेळणारे गौण खनिज उत्खनन करणारे वाळू तस्कर",
    ];
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.27,
        child: CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 0.8,
              // enlargeCenterPage: true,
              disableCenter: true,
              scrollDirection: Axis.vertical,
              autoPlay: true,
              enableInfiniteScroll: true),
          items: ups.map((title) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: GREY_BACKGROUND_COLOR,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ));
  }
}

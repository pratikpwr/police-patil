import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

class ImpNewsWidget extends StatelessWidget {
  const ImpNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(GetNews());
    return Container(
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
                ),
              ],
            ),
            spacer(height: 8),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Loading();
                } else if (state is NewsLoaded) {
                  if (state.newsResponse.data!.isEmpty) {
                    return NoRecordFound();
                  } else {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              viewportFraction: 0.8,
                              // enlargeCenterPage: true,
                              disableCenter: true,
                              scrollDirection: Axis.vertical,
                              autoPlay: true,
                              enableInfiniteScroll: true),
                          items:
                              state.newsResponse.data!.map((NewsData newsData) {
                            return Builder(
                              builder: (BuildContext context) {
                                return NewsDetailsWidget(
                                  newsData: newsData,
                                );
                              },
                            );
                          }).toList(),
                        ));
                  }
                } else if (state is NewsLoadError) {
                  return SomethingWentWrong();
                } else {
                  return SomethingWentWrong();
                }
              },
            ),
          ],
        ));
  }
}

class NewsDetailsWidget extends StatelessWidget {
  final NewsData newsData;

  const NewsDetailsWidget({Key? key, required this.newsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (newsData.link != null) {
          launchUrl(newsData.link!);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CONTAINER_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Todo see doc button
            Text(
              newsData.title!,
              maxLines: 4,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  newsData.date!.toIso8601String().substring(0, 10),
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                if (newsData.file != null)
                  IconButton(
                      onPressed: () {
                        launchUrl("http://${newsData.file!}");
                      },
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        size: 24,
                      ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// var ups = [
//   "जप्ती मालाचा प्रकार बेवारस वाहने दागिने गौण खनिज इतर, जप्ती मालाचा प्रकार बेवारस वाहने दागिने गौण खनिज इतर.",
//   "हे हस्तलिखित प्रिंटिंग होणार हातासो ते लिहावे असे आवाहन  करतो व ते आपल्या फोटोसह माझ्या नावाने किंवा शाळेच्या नावाने पोस्टाने किंवा कुरिअर ने पाठवाव्यात",
//   "अवैद्य दारू विक्री करणारे गुटका जुगार मटका चालविणारे इतर जुगार खेळणारे गौण खनिज उत्खनन करणारे वाळू तस्कर",
// ];

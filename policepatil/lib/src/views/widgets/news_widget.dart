import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/screens/news_screen.dart';
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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const NewsScreen();
                }));
              },
              child: Row(
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
                                return NewsWidget(
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

class NewsWidget extends StatelessWidget {
  final NewsData newsData;

  const NewsWidget({Key? key, required this.newsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (newsData.link != null) {
          launchUrl(newsData.link!);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CONTAINER_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsData.title!,
              maxLines: 4,
              style: Styles.titleTextStyle(),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showDate(newsData.date!),
                  style: Styles.subTitleTextStyle(),
                ),
                if (newsData.file != null)
                  IconButton(
                      onPressed: () {
                        launchUrl("http://${newsData.file!}");
                      },
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        size: 22,
                      ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

// TODO : will need pagination here
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(GetNews());
    return Scaffold(
        appBar: AppBar(title: const Text("महत्त्वाच्या घडामोडी !")),
        body: BlocListener<NewsBloc, NewsState>(listener: (context, state) {
          if (state is NewsLoadError) {
            showSnackBar(context, state.error);
          }
        }, child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Loading();
            } else if (state is NewsLoaded) {
              if (state.newsResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.newsResponse.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return NewsDetailsWidget(
                              newsData: state.newsResponse.data![index]);
                        }),
                  ),
                );
              }
            } else if (state is NewsLoadError) {
              return SomethingWentWrong();
            } else {
              return SomethingWentWrong();
            }
          },
        )));
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

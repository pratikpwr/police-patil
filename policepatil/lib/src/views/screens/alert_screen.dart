import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:shared/shared.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

// TODO : will need pagination here
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlertBloc>(context).add(GetAlerts());
    return Scaffold(
        appBar: AppBar(
          title: const Text(NOTICE),
          automaticallyImplyLeading: false,
        ),
        body: BlocListener<AlertBloc, AlertState>(listener: (context, state) {
          if (state is AlertLoadError) {
            showSnackBar(context, state.error);
          }
        }, child: BlocBuilder<AlertBloc, AlertState>(
          builder: (context, state) {
            if (state is AlertLoading) {
              return const Loading();
            } else if (state is AlertLoaded) {
              if (state.alertResponse.data!.isEmpty) {
                return NoRecordFound();
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.alertResponse.data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return AlertDetailsWidget(
                              alertData: state.alertResponse.data![index],
                            );
                          })),
                );
              }
            } else if (state is AlertLoadError) {
              return SomethingWentWrong();
            } else {
              return SomethingWentWrong();
            }
          },
        )));
  }
}

class AlertDetailsWidget extends StatelessWidget {
  final AlertData alertData;

  const AlertDetailsWidget({Key? key, required this.alertData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (alertData.otherLink != null) {
          launchUrl(alertData.otherLink!);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CONTAINER_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (alertData.photo != null && !(alertData.videoLink != null))
              CachedNetworkImage(
                imageUrl: "http://${alertData.photo!}",
                width: double.infinity,
                height: 170,
              ),
            if (alertData.videoLink != null)
              VideoPlayerWidget(videoUrl: alertData.videoLink!),
            spacer(),
            Text(
              alertData.title!,
              style: Styles.titleTextStyle(),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showDate(alertData.date!),
                  style: Styles.subTitleTextStyle(),
                ),
                if (alertData.file != null)
                  IconButton(
                      onPressed: () {
                        launchUrl("http://${alertData.file!}");
                      },
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        size: 22,
                      ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? videoId = youtubeUrlToId(videoUrl);
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId!,
      params: YoutubePlayerParams(
        playlist: [videoId],
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return YoutubePlayerIFrame(
      controller: controller,
      aspectRatio: 16 / 9,
    );
  }
}

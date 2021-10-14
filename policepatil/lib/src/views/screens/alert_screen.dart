import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          title: Text(
            NOTICE,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          automaticallyImplyLeading: false,
        ),
        body: BlocListener<AlertBloc, AlertState>(listener: (context, state) {
          if (state is AlertLoadError) {
            showSnackBar(context, state.error);
          }
        }, child: BlocBuilder<AlertBloc, AlertState>(
          builder: (context, state) {
            if (state is AlertLoading) {
              return loading();
            } else if (state is AlertLoaded) {
              if (state.alertResponse.data!.isEmpty) {
                return noRecordFound();
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
              return somethingWentWrong();
            } else {
              return somethingWentWrong();
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
            color: GREY_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Todo see doc button
            // if video then don't show photo
            if (alertData.photo != null && !(alertData.videoLink != null))
              CachedNetworkImage(
                imageUrl: alertData.photo!,
                width: double.infinity,
                height: 180,
              ),
            if (alertData.videoLink != null)
              VideoPlayerWidget(videoUrl: alertData.videoLink!),
            spacer(),
            Text(
              alertData.title!,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              alertData.date!.toIso8601String().substring(0, 10),
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
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

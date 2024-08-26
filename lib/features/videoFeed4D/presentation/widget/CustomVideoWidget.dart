import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_feed_4d/features/videoFeed4D/model/VideoModel.dart';
import 'package:video_player/video_player.dart';

class CustomVideoWidget extends StatefulWidget {
  final VideoModel videoModel;
  const CustomVideoWidget({super.key, required this.videoModel});

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  late VideoPlayerController _videoPlayerController;
  bool isReady = false;
  bool isPlay = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoModel.videoLink),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(0.30);

    _videoPlayerController.initialize().then((_) {
      isReady = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dimW = MediaQuery.of(context).size.width;
    var dimH = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        isPlay = !isPlay;
        if (isPlay) {
          _videoPlayerController.play();
        } else {
          _videoPlayerController.pause();
        }
      },
      onDoubleTap: () {
        debugPrint("tat - doubletap");
      },
      onFocusChange: (bool onboolVal) {
        debugPrint("tat - onFocusChange");
      },
      onLongPress: () {
        debugPrint("tat - onlong press");
      },
      child: isReady
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  VideoPlayer(_videoPlayerController),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.videoModel.title,
                                  style: const TextStyle(
                                      overflow: TextOverflow.fade,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        reelMiniWidget(widget.videoModel.upvoteCount.toString(),
                            Icons.favorite_rounded),
                        reelMiniWidget(
                            widget.videoModel.commentCount.toString(),
                            Icons.chat_bubble_outline),
                        reelMiniWidget(widget.videoModel.shareCount.toString(),
                            Icons.share),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  widget.videoModel.pictureUrl,
                                  fit: BoxFit.contain,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.videoModel.username,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(
                      widget.videoModel.thumbnailUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: dimH / 2,
                    left: dimW / 2,
                    child: const CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget reelMiniWidget(String widgetName, IconData icon) {
  return Column(
    children: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: widgetName == "Like" ? Colors.red : Colors.white,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        widgetName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(
        height: 40,
      ),
    ],
  );
}

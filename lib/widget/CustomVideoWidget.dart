import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_feed_4d/model/VideoModel.dart';
import 'package:video_feed_4d/pages/LoadPage.dart';
import 'package:video_feed_4d/view/CommentPage.dart';
import 'package:video_feed_4d/widget/MiniWidget.dart';
import 'package:video_feed_4d/utils/SlideRightRoute.dart';
import 'package:video_player/video_player.dart';

import '../provider/CommentFeedProvider.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentFeedProvider>(context, listen: false)
          .fetchAllComments(widget.videoModel.id);
    });

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoModel.videoLink),
    );

    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(0.05);

    _videoPlayerController.initialize().then((_) {
      isReady = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dimW = MediaQuery.of(context).size.width;
    var dimH = MediaQuery.of(context).size.height;

    return Consumer(
      builder: ((context, value, child) {
        return GestureDetector(
          onTap: () {
            isPlay = !isPlay;
            if (isPlay) {
              _videoPlayerController.play();
            } else {
              _videoPlayerController.pause();
            }
          },
          onLongPressStart: (details) {
            if (isPlay) {
              isPlay = false;
              _videoPlayerController.pause();
            }
          },
          onLongPressEnd: (details) {
            if (!isPlay) {
              isPlay = true;
              _videoPlayerController.play();
            }
          },
          onHorizontalDragUpdate: (details) async {
            //pull up the comment videos

            _videoPlayerController.pause();
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //   content: Text(
            //     'Display comments...',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   duration: Duration(seconds: 2),
            //   backgroundColor: Colors.orange,
            // ));

            if (widget.videoModel.childCountVideo > 0) {
              if (details.delta.dx < 0) {
                await Navigator.of(context).push(
                  SlideRightRoute(
                    page: CommentPage(
                      id: widget.videoModel.id,
                      title: widget.videoModel.title,
                      thumbnail: widget.videoModel.thumbnailUrl,
                      totalCommentCount: widget.videoModel.childCountVideo,
                    ),
                  ),
                );
                _videoPlayerController.play();
              }
            } 

            return;
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
                            ReelMiniWidget(
                                widgetName:
                                    widget.videoModel.upvoteCount.toString(),
                                icon: Icons.favorite_rounded),
                            ReelMiniWidget(
                                widgetName:
                                    widget.videoModel.commentCount.toString(),
                                icon: Icons.chat_bubble_outline),
                            ReelMiniWidget(
                                widgetName:
                                    widget.videoModel.shareCount.toString(),
                                icon: Icons.share),
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
                      Positioned(
                        top: dimH / 2,
                        bottom: dimH / 2,
                        left: dimW / 2,
                        right: dimW / 2,
                        child: const LoadPage(),
                      ),
                      Hero(
                        tag: widget.videoModel.id,
                        child: Container(
                          width: dimW,
                          height: dimH,
                          child: Image.network(widget.videoModel.thumbnailUrl),
                        ),
                      )
                    ],
                  ),
                ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_feed_4d/model/CommentModel.dart';
import 'package:video_player/video_player.dart';

import '../pages/LoadPage.dart';
import 'MiniWidget.dart';

class VideoCommentPage extends StatefulWidget {
  final CommentModel comment;
  final int id;

  const VideoCommentPage({super.key, required this.comment, required this.id});

  @override
  State<VideoCommentPage> createState() => _VideoCommentPageState();
}

class _VideoCommentPageState extends State<VideoCommentPage> {
  late VideoPlayerController _videoPlayerController;
  bool isReady = false;
  bool isPlay = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.comment.videoLink),
    );

    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(0.3);

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

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              child: isReady
                  ? Stack(
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
                                        widget.comment.title.length > 80
                                            ? widget.comment.title
                                                .substring(0, 80)
                                            : widget.comment.title,
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
                                      widget.comment.upvoteCount.toString(),
                                  icon: Icons.favorite_rounded),
                              ReelMiniWidget(
                                  widgetName:
                                      widget.comment.commentCount.toString(),
                                  icon: Icons.chat_bubble_outline),
                              ReelMiniWidget(
                                  widgetName:
                                      widget.comment.shareCount.toString(),
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
                                        widget.comment.pictureUrl,
                                        fit: BoxFit.contain,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.comment.username,
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
                    )
                  : const Center(
                      child: const LoadPage(),
                    ),
            ),
          ),
        ],
      )
          /*
         Container(
          child: isReady
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    VideoPlayer(_videoPlayerController!),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.comment.title,
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
                         ReelMiniWidget(widgetName:widget.comment.upvoteCount.toString(),
                            icon:  Icons.favorite_rounded),
                          ReelMiniWidget(
                             widgetName:  widget.comment.commentCount.toString(),
                            icon:   Icons.chat_bubble_outline),
                          ReelMiniWidget(
                            widgetName:  widget.comment.shareCount.toString(),
                            icon:   Icons.share),
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
                                    widget.comment.pictureUrl,
                                    fit: BoxFit.contain,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                               const SizedBox(width: 10),
                                Text(
                                  widget.comment.username,
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
                      bottom: dimH/2,
                      left: dimW / 2,
                      right: dimW/2,
                      child: const LoadPage(),
                    ),
                  ],
                ),
              ),
        ),
        */
          ),
    );
  }
}

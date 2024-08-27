import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_feed_4d/features/videoFeed4D/data/provider/CommentFeedProvider.dart';
import 'package:video_feed_4d/features/videoFeed4D/presentation/pages/LoadPage.dart';
import 'package:video_player/video_player.dart';

import '../widget/CommentVideoPage.dart';

class CommentPage extends StatefulWidget {
  final int id;
  final String title;
  final String thumbnail;

  const CommentPage(
      {super.key,
      required this.id,
      required this.title,
      required this.thumbnail});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late VideoPlayerController _commentVideoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<CommentFeedProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: LoadPage(),
            );
          }
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Returned to main feed...'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.blue,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            child: Column(
              children: [
                Expanded(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 20 / 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: widget.id,
                            child: Image.network(
                              widget.thumbnail,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(
                                widget.title.length > 80
                                    ? widget.title.substring(0, 80) + '...'
                                    : widget.title + '...',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: PageView.builder(
                    itemCount: value.commentFeed.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      return value.isLoading
                          ? const LoadPage()
                          : VideoCommentPage(
                              comment: value.commentFeed[index], id: widget.id);
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

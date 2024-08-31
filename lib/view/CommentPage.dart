import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_feed_4d/pages/LoadPage.dart';
import 'package:video_player/video_player.dart';

import '../provider/CommentFeedProvider.dart';
import '../widget/CommentVideoPage.dart';
import '../widget/PageViewDotIndicator.dart';

class CommentPage extends StatefulWidget {
  final int id;
  final String title;
  final String thumbnail;
  final int totalCommentCount;

  const CommentPage({
    super.key,
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.totalCommentCount,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late VideoPlayerController _commentVideoController;
  late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(80.0),
       child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: 
          Row(children: [
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
       ),),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<CommentFeedProvider>(
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
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: value.commentFeed.length,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    itemBuilder: ((context, index) {
                      return value.isLoading
                          ? const LoadPage()
                          : VideoCommentPage(
                              comment: value.commentFeed[index],
                              id: widget.id);
                    }),
                  ),
                  Positioned(
                    right: 0,
                    top: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, right: 2),
                      child: Transform.rotate(
                        angle: pi / 2,
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 51,
                          height: 51,
                          child: PageViewDotIndicator(
                            hasChildren: false,
                            currentItem: selectedIndex,
                            count: widget.totalCommentCount,
                            alignment: Alignment.centerRight,
                            unselectedColor: Colors.grey,
                            selectedColor:
                                const Color.fromARGB(232, 255, 255, 255),
                            size: const Size(10, 10),
                            unselectedSize: const Size(6, 6),
                            duration: const Duration(milliseconds: 200),
                            boxShape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

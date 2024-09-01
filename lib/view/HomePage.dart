import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_feed_4d/provider/VideoFeedProvider.dart';
import 'package:video_feed_4d/provider/VideoIndexProvider.dart';
import 'package:video_feed_4d/widget/CustomVideoWidget.dart';
import '../pages/LoadPage.dart';

import 'dart:math';

import '../widget/PageViewDotIndicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  late int selectedReelVideoIndex;

  VideoIndexProvider indexProvider = VideoIndexProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedReelVideoIndex = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoFeedProvider>(context, listen: false).fetchAllReels();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoFeedProvider>(builder: (context, value, child) {
      return Scaffold(
        body: value.isLoading
            ? const Center(
                child: LoadPage(),
              )
            : Stack(
                children: [
                  PageView.builder(
                      itemCount: value.videoFeeds.length,
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (value) {
                        debugPrint("babu Page changed value -> $value");
                        debugPrint(
                            "babu On index changed ->${indexProvider.currentIndex}");

                        //Eg: Value gives => 1 ,Value-1 gives index..
                        
                        indexProvider.setNotifierValue(value);
                        indexProvider.set(value - 1);
                      },
                      itemBuilder: (context, index) {
                        final reelVideo = value.videoFeeds[index];

                        return CustomVideoWidget(videoModel: reelVideo);
                      }),
                  Positioned(
                    right: 0,
                    top: 90,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, right: 2),
                      child: Transform.rotate(
                        angle: pi / 2,
                        alignment: Alignment.topRight,
                        child: ValueListenableBuilder(
                          valueListenable: indexProvider.videoIndexNotifier,
                          builder: (context, notifiedValue, child) {
                            debugPrint("The value listenable : $notifiedValue");
                            debugPrint(
                                "hasChildren : ${value.videoFeeds[notifiedValue].childCountVideo != 0}");

                            return SizedBox(
                              width: 51,
                              height: 51,
                              child: PageViewDotIndicator(
                                hasChildren: value.videoFeeds[notifiedValue]
                                     .childCountVideo > 0,
                                currentItem: notifiedValue,
                                count: value.videoFeeds.length,
                                alignment: Alignment.centerRight,
                                unselectedColor:const Color.fromARGB(255, 123, 120, 120),
                                selectedColor:
                                    const Color.fromARGB(232, 255, 255, 255),
                                size: const Size(10, 10),
                                unselectedSize: const Size(6, 6),
                                duration: const Duration(milliseconds: 200),
                                boxShape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );

      // This trailing comma makes auto-formatting nicer for build methods.
    });
  }
}

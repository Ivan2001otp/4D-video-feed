import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_feed_4d/features/videoFeed4D/data/provider/VideoFeedProvider.dart';
import 'package:video_feed_4d/features/videoFeed4D/presentation/widget/CustomVideoWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
    debugPrint("didChangeDependencies\n");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoFeedProvider>(context, listen: false).fetchAllReels();
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Consumer<VideoFeedProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : PageView.builder(
                  itemCount: value.videoFeeds.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final reelVideo = value.videoFeeds[index];
                    return CustomVideoWidget(videoModel: reelVideo);
                  })
          );

      // This trailing comma makes auto-formatting nicer for build methods.
    });
  }
}

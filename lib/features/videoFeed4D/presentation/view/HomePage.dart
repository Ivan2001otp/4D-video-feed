import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_feed_4d/features/videoFeed4D/data/provider/VideoFeedProvider.dart';

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
      Provider.of<VideoFeedProvider>(context,listen: false).fetchAllReels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoFeedProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: value.videoFeeds.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          subtitle: Text(
                            value.videoFeeds[index].pictureUrl,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                )
          // This trailing comma makes auto-formatting nicer for build methods.
          );
    });
  }
}

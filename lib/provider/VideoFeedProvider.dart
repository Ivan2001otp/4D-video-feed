import 'package:flutter/material.dart';
import 'package:video_feed_4d/service/VideoFeedService.dart';
import 'package:video_feed_4d/model/VideoModel.dart';

class VideoFeedProvider extends ChangeNotifier {
  List<VideoModel> _videoFeeds = [];
  List<VideoModel> get videoFeeds => _videoFeeds;

  VideoFeedService _videoFeedService = VideoFeedService();

  bool isLoading = false;

  Future<void> fetchAllReels() async {
    isLoading = true;
    notifyListeners();

    _videoFeeds = await _videoFeedService.fetchVideoFeeds();

    isLoading = false;
    notifyListeners();
  }
}

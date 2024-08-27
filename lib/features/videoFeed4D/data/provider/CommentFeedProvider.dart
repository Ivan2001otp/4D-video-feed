import 'package:flutter/material.dart';
import 'package:video_feed_4d/features/videoFeed4D/model/CommentModel.dart';

import '../service/VideoFeedService.dart';

class CommentFeedProvider extends ChangeNotifier {
  List<CommentModel> _commentFeed = [];
  List<CommentModel> get commentFeed => _commentFeed;
  VideoFeedService _videoFeedService = VideoFeedService();

  bool isLoading = false;

  Future<void> fetchAllComments(int id) async {
    isLoading = true;
    notifyListeners();
   
    _commentFeed = await _videoFeedService.fetchVideoComments(id);
    isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_feed_4d/features/videoFeed4D/model/CommentModel.dart';
import '../../../../utils/constants.dart';
import '../../model/VideoModel.dart';

class VideoFeedService {
  Future<List<VideoModel>> fetchVideoFeeds() async {
    try {
      final videoResponse = await http.get(Uri.parse(VIDEO_FEED_URL));

      if (videoResponse.statusCode == 200) {
        final data = videoResponse.body;
        // debugPrint(data);

        final json = jsonDecode(data);

        List<VideoModel> videoFeeds =
            (json['posts'] as List).map((e) => VideoModel.fromJson(e)).toList();

        return videoFeeds;
      } else {
        throw Exception('Failed to load the videos Feed');
      }
    } catch (e) {
      debugPrint(
        'Error fetching video feed ->${e.toString()}',
      );
    }

    return [];
  }

  Future<List<CommentModel>> fetchVideoComments(int id) async {
    try {
     
      final commentResponse = await http
          .get(Uri.parse("https://api.wemotions.app/posts/$id/replies"));

      if (commentResponse.statusCode == 200) {
        final data = commentResponse.body;
        final json = jsonDecode(data);

        List<CommentModel> commentFeeds = (json['post'] as List)
            .map((e) => CommentModel.fromJson(e))
            .toList();

        commentFeeds.forEach((element) {
          debugPrint(element.title);
        });
        return commentFeeds;
      } else {
        throw Exception("Failed to load comment videos !");
      }
    } catch (e) {
      debugPrint('Error captured while fetching comments ${e.toString()}');
    }

    return [];
  }
}

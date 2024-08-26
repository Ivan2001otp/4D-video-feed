import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
}

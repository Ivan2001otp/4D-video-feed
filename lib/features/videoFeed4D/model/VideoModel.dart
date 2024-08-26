import 'dart:core';
import 'dart:ffi';

class VideoModel {
  final int id;
  final String slug;
  final int upvoteCount;
  final int commentCount;
  final int childCountVideo;
  final String videoLink;
  final String username;
  final String thumbnailUrl;
  final String pictureUrl;

  VideoModel({
    required this.id,
    required this.slug,
    required this.upvoteCount,
    required this.commentCount,
    required this.childCountVideo,
    required this.videoLink,
    required this.username,
    required this.thumbnailUrl,
    required this.pictureUrl,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      slug: json['slug'],
      upvoteCount: json['upvote_count'],
      commentCount: json['comment_count'],
      childCountVideo: json['child_video_count'],
      videoLink: json['video_link'],
      username: json['username'],
      thumbnailUrl: json['thumbnail_url'],
      pictureUrl: json['picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "slug":slug,
      "upvote_count":upvoteCount,
      "comment_count":commentCount,
      "child_video_count":childCountVideo,
      "video_link":videoLink,
      "username":username,
      "thumbnail_url":thumbnailUrl,
      "picture_url":pictureUrl,
    };
  }
}

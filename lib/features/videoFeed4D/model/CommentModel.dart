class CommentModel {
  final int id;
  final String title;
  final int commentCount;
  final int upvoteCount;
  final int shareCount;
  final String videoLink;
  final String thumbnailUrl;
  final String pictureUrl;
  final String username;

  CommentModel({
    required this.id,
    required this.title,
    required this.commentCount,
    required this.upvoteCount,
    required this.shareCount,
    required this.videoLink,
    required this.thumbnailUrl,
    required this.pictureUrl,
    required this.username,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      title: json['title'],
      commentCount: json['comment_count'],
      upvoteCount: json['upvote_count'],
      shareCount: json['share_count'],
      videoLink: json['video_link'],
      thumbnailUrl: json['thumbnail_url'],
      pictureUrl: json['picture_url'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "comment_count": commentCount,
      "upvote_count": upvoteCount,
      "share_count": shareCount,
      "video_link": videoLink,
      "thumbnail_url": thumbnailUrl,
      "picture_url": pictureUrl,
      "username": username,
    };
  }
}

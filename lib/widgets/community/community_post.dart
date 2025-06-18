class CommunityPost {
  final String title;
  final String content;
  final String author;
  final String date;
  final bool isRecruiting;

  CommunityPost({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    this.isRecruiting = false,
  });
}

import 'package:flutter/material.dart';

class CommunityPostDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String date;
  final bool isRecruiting;
  final String? fileName;

  const CommunityPostDetailPage({
    super.key,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.isRecruiting,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('작성자: $author', style: const TextStyle(color: Colors.grey)),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            if (isRecruiting)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('팀원 모집 중', style: TextStyle(color: Colors.teal)),
              ),
            const SizedBox(height: 16),
            Text(content, style: const TextStyle(fontSize: 16)),
            if (fileName != null) ...[
              const SizedBox(height: 24),
              const Text('첨부파일:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(fileName!),
            ],
          ],
        ),
      ),
    );
  }
}

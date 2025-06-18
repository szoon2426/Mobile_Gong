import 'package:flutter/material.dart';
import 'community_post_card.dart';
import 'community_post.dart';

class CommunityPostList extends StatelessWidget {
  const CommunityPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _buildPostList(context, filter: 'all'),       // 전체
        _buildPostList(context, filter: 'recruit'),   // 팀원모집
      ],
    );
  }

  Widget _buildPostList(BuildContext context, {required String filter}) {
    // 샘플 데이터
    final List<CommunityPost> samplePosts = [
      CommunityPost(
        title: '공모전 팀원 구해요',
        content: '디자인 가능하신 분 계시면 댓글 주세요!',
        author: '홍길동',
        date: '2025.06.17',
        isRecruiting: true,
      ),
      CommunityPost(
        title: '질문 있습니다!',
        content: '신청 링크가 안 들어가져요ㅠ',
        author: '이몽룡',
        date: '2025.06.15',
        isRecruiting: false,
      ),
    ];

    // 탭 필터링
    List<CommunityPost> filteredPosts = switch (filter) {
      'recruit' => samplePosts.where((post) => post.isRecruiting).toList(),
      _ => samplePosts, // 전체 or 기타
    };

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return CommunityPostCard(post: post);
      },
    );
  }
}

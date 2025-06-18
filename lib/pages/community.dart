import 'package:flutter/material.dart';
import '../widgets/header_section.dart';
import '../widgets/community/community_tab_bar.dart';
import '../widgets/community/community_post_list.dart';
import '../widgets/community/community_write_form.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              HeaderSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "community",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: const [
                        Text(
                          "00:00:00",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.timer, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              CommunityTabBar(),
              Expanded(child: CommunityPostList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // 키보드에 밀리지 않도록
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => const Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: CommunityWriteForm(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CommunityWriteForm extends StatefulWidget {
  const CommunityWriteForm({super.key});

  @override
  State<CommunityWriteForm> createState() => _CommunityWriteFormState();
}

class _CommunityWriteFormState extends State<CommunityWriteForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool isRecruiting = false;
  String? attachedFileName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('글쓰기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            /// 제목
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(height: 12),

            /// 내용
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: '내용'),
            ),
            const SizedBox(height: 12),

            /// 팀원모집 체크박스
            Row(
              children: [
                Checkbox(
                  value: isRecruiting,
                  onChanged: (value) {
                    setState(() {
                      isRecruiting = value ?? false;
                    });
                  },
                ),
                const Text('팀원 모집')
              ],
            ),

            const SizedBox(height: 20),

            /// 등록 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 등록 처리
                  Navigator.pop(context);
                },
                child: const Text('등록'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

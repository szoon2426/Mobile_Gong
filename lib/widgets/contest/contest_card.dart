import 'package:flutter/material.dart';

class ContestCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String dDay;
  final double imgHeight;

  const ContestCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.dDay,
    required this.imgHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //AspectRatio(
            //aspectRatio: 1, // 정사각형 이미지
          SizedBox(
            height: imgHeight,
            width: double.infinity,  
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[200], child: Icon(Icons.image_not_supported)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  dDay,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

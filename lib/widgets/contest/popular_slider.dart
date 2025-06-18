import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'contest_card.dart';

class PopularSlider extends StatelessWidget {
  const PopularSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/sample1.png',
      'assets/sample2.png',
      'assets/sample3.png',
      'assets/sample4.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "지금 인기있는 공모전!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        CarouselSlider(
          options: CarouselOptions(
            height: 260,
            enlargeCenterPage: true,
            enableInfiniteScroll: true, // ✅ 무한 루프
            viewportFraction: 0.8,
            autoPlay: false, // true 하면 자동 슬라이드
          ),
          items: imagePaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return ContestCard(
                  imagePath: path,
                  title: '공모전 이름',
                  dDay: 'D-12',
                  imgHeight: 140,
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

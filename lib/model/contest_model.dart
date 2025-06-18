class Contest {
  final String title;
  final String imagePath;
  final String dDay;

  Contest({
    required this.title,
    required this.imagePath,
    required this.dDay,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      title: json['title'],
      imagePath: json['imagePath'],
      dDay: json['dDay'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'imagePath': imagePath,
        'dDay': dDay,
      };
}

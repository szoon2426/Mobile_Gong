import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  static Future<File> _getFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  /// ✅ 날짜별 저장 ("2025-06-17": 185)
  static Future<void> writeStudyData(String date, int minutes) async {
    final file = await _getFile('study_data.json');
    final contents = await file.readAsString().catchError((_) => '{}');
    final data = json.decode(contents) as Map<String, dynamic>;

    final existing = data[date] ?? 0;
    data[date] = (existing as int) + minutes;
    print("파일 저장 위치: " + file.path);

    await file.writeAsString(json.encode(data));
  }

  /// ✅ 키워드별 저장 ("flutter": 120)
  static Future<void> writeKeywordData(String keyword, int minutes) async {
    final file = await _getFile('keyword_data.json');
    final contents = await file.readAsString().catchError((_) => '{}');
    final data = json.decode(contents) as Map<String, dynamic>;

    final existing = data[keyword] ?? 0;
    data[keyword] = (existing as int) + minutes;

    await file.writeAsString(json.encode(data));
  }
}

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

class ManufacturersDataService {
  static final ManufacturersDataService _instance =
      ManufacturersDataService._internal();
  factory ManufacturersDataService() => _instance;

  ManufacturersDataService._internal();

  Map<String, List<Map<String, dynamic>>>? _carData;

  Future<Map<String, List<Map<String, dynamic>>>> getCarData() async {
    if (_carData != null) return _carData!;

    final ByteData data = await rootBundle.load('assets/Car_weights.xlsx');
    final excel = Excel.decodeBytes(data.buffer.asUint8List());

    final sheet = excel.tables.keys.first;
    final rows = excel.tables[sheet]!.rows;

    Map<String, List<Map<String, dynamic>>> carMap = {};
    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length < 3) continue;

      final manufacturer = row[0]?.value.toString() ?? '';
      final model = row[1]?.value.toString() ?? '';
      final weight = row[2]?.value;

      if (manufacturer.isEmpty || model.isEmpty || weight == null) continue;

      carMap.putIfAbsent(manufacturer, () => []);
      carMap[manufacturer]!.add({'model': model, 'weight': weight});
    }
    if (!carMap.containsKey('Other')) {
      carMap['Other'] = [];
    }

    _carData = carMap;
    return _carData!;
  }
}

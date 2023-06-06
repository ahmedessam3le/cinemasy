import 'package:hive/hive.dart';

abstract class CinemasyLocalDataSource {
  Future<void> openBox();
  Future<void> clearCache();
}

class CinemasyLocalDataSourceImpl implements CinemasyLocalDataSource {
  static const String preferencesBox = 'preferences-box';
  Box<dynamic>? _box;

  @override
  Future<void> openBox() async => _box = await Hive.openBox(preferencesBox);

  @override
  Future<void> clearCache() async => await _box?.clear();
}

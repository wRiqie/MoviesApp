import 'package:flutter/services.dart';

class EnvUtil {
  static final EnvUtil _singleton = EnvUtil._internal();

  factory EnvUtil() {
    return _singleton;
  }

  EnvUtil._internal();

  static const String _envPath = '.env';
  static final Map<String, dynamic> _map = {};

  static Future<String> _getEnv({String? path}) {
    return rootBundle.loadString(path ?? _envPath);
  }

  static Future<void> _loadMap({String? path}) async {
    final env = await _getEnv(path: path);
    final items = env.split('\n');

    for (var item in items) {
      final value = item.split('=');
      _map.addAll({value[0]: value[1]});
    }
  }

  static Future<dynamic> get(String key, {String? path}) async {
    if (_map.isEmpty) {
      await _loadMap(path: path);
    }

    return _map[key];
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import '../models/tv_show.dart';

class StorageService {
  static const String boxName = 'favorite_shows_box';
  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Box get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Hive box not initialized. Call StorageService.init() first.');
    }
    return _box!;
  }

  /// Retrieve all favorited TV shows from Hive
  static List<TvShow> getFavorites() {
    try {
      final List<TvShow> list = [];
      for (var key in box.keys) {
        final raw = box.get(key);
        if (raw != null && raw is Map) {
          list.add(TvShow.fromJson(Map<dynamic, dynamic>.from(raw)));
        }
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  /// Check if a show is favorited
  static bool isFavorite(int id) {
    return box.containsKey(id.toString());
  }

  /// Add a show to favorites
  static Future<void> addFavorite(TvShow show) async {
    await box.put(show.id.toString(), show.toJson());
  }

  /// Remove a show from favorites
  static Future<void> removeFavorite(int id) async {
    await box.delete(id.toString());
  }

  /// Toggle favorite status, returns true if now favorited, false if removed
  static Future<bool> toggleFavorite(TvShow show) async {
    if (isFavorite(show.id)) {
      await removeFavorite(show.id);
      return false;
    } else {
      await addFavorite(show);
      return true;
    }
  }
}

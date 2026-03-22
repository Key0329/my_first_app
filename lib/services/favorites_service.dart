import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService extends ChangeNotifier {
  static const _keyFavorites = 'favorites';

  final SharedPreferences _prefs;
  Set<String> _favorites = {};

  FavoritesService(this._prefs);

  Set<String> get favorites => Set.unmodifiable(_favorites);

  bool isFavorite(String toolId) => _favorites.contains(toolId);

  void loadFromPrefs() {
    final list = _prefs.getStringList(_keyFavorites);
    _favorites = list != null ? Set<String>.from(list) : {};
  }

  Future<void> toggleFavorite(String toolId) async {
    if (_favorites.contains(toolId)) {
      _favorites.remove(toolId);
    } else {
      _favorites.add(toolId);
    }
    notifyListeners();
    await _prefs.setStringList(_keyFavorites, _favorites.toList());
  }
}

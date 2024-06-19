import 'dart:convert';

import 'package:education/templates/middleAssignment/data/shower_take.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _showerTakes = [];

  Future<void> addShowerTake(ShowerTake showerTake) async {
    final prefs = await SharedPreferences.getInstance();
    List<ShowerTake> _showerTakes = await getShowerTakes();
    _showerTakes.add(showerTake);
    String showerTakesPref = ShowerTake.encode(_showerTakes);
    prefs.setString('showerTakes', showerTakesPref);
  }

  Future<List<ShowerTake>> getShowerTakes() async {
    final prefs = await SharedPreferences.getInstance();
    String? showerTakesPref = prefs.getString('showerTakes');
    if (showerTakesPref == null) {
      return [];
    }
    List<ShowerTake> showerTakes = ShowerTake.decode(showerTakesPref);
    return showerTakes;
  }

  void clearShowerTakes() async {
    final prefs = await SharedPreferences.getInstance();
    String showerTakesPref = ShowerTake.encode([]);
    prefs.setString('showerTakes', showerTakesPref);
  }
}

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});


class ShowerTakesState extends StateNotifier<List<ShowerTake>> {
  final LocalStorageService _localStorageService;

  ShowerTakesState(this._localStorageService) : super([]) {
    _loadShowerTakes();
  }

  void _loadShowerTakes() async {
    state = await _localStorageService.getShowerTakes(); 
  }

  void addShowerTake(ShowerTake showerTake) {
    state.add(showerTake);
    _localStorageService.addShowerTake(showerTake);
  }

  void clearShowerTakes() {
    state = [];
    _localStorageService.clearShowerTakes();
  }

  List<ShowerTake> getShowerTakes() {
    return state;
  }
}

final showerTakesProvider = StateNotifierProvider<ShowerTakesState, List<ShowerTake>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return ShowerTakesState(localStorageService);
});
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:contrast_shower_app/models/dataModel.dart';

class DataProvider extends ChangeNotifier {
  late List<DataModel> _dataList = [];

  List<DataModel> get dataList => _dataList;

  Future<void> loadDataFromHive() async {
    var box = await Hive.openBox('history');
    List<dynamic> dataListFromBox = box.get('dataList', defaultValue: []);
    
    // Преобразуем данные из Hive в экземпляры DataModel
    _dataList = dataListFromBox.map((data) => DataModel(
      warmtemp: data['warmtemp'] ?? 0,
      coldTemp: data['coldtemp'] ?? 0,
      timer: data['timer'] ?? 0,
    )).toList();

    notifyListeners();
  }

  Future<void> saveDataToHive(int warmTemp, int coldTemp, int timer) async {
    var box = await Hive.openBox('history');
    
    // Получаем текущий список данных или создаем новый, если он пустой
    List<dynamic> dataListFromBox = box.get('dataList', defaultValue: []);
    
    // Добавляем новые данные в список
    dataListFromBox.add({
      'warmtemp': warmTemp,
      'coldtemp': coldTemp,
      'timer': timer,
    });

    // Сохраняем обновленный список в Hive
    await box.put('dataList', dataListFromBox);

    // Закрываем бокс Hive
    await box.close();

    // Перезагружаем данные из Hive
    await loadDataFromHive(); 
  }
}


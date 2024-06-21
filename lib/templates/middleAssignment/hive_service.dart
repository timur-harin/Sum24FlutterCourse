import 'package:hive/hive.dart';
import 'data.dart';

class HiveService {
  static initHive() async {
    Hive.registerAdapter(DataAdapter());
  }

  static void add(Data data) {
    Hive.box<Data>('data').add(data);
  }

  static List<Data> getAll() {
    final result = Hive.box<Data>('data').values.toList();
    return result;
  }
}

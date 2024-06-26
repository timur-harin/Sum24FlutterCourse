// {
// "userId": 1,
// "id": 1,
// "title": "delectus aut autem",
// "completed": false
// }
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@freezed
class TODO with _$TODO {
  const factory TODO({
    required int userId,
    required int id,
    required String title,
    required bool? completed,
  }) = _TODO;

  factory TODO.fromJson(Map<String, Object?> json) => _$TODOFromJson(json);
}

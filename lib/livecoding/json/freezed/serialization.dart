import 'package:freezed_annotation/freezed_annotation.dart';

part 'serialization.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _Post;
}

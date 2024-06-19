import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_status_code.freezed.dart';
part 'cat_status_code.g.dart';

@freezed
class CatStatusCode with _$CatStatusCode {
  const factory CatStatusCode({
    required int statusCode,
    required String message,
  }) = _CatStatusCode;

  factory CatStatusCode.fromJson(Map<String, dynamic> json) => _$CatStatusCodeFromJson(json);
}

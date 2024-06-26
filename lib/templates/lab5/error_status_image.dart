import 'package:flutter/material.dart';


Widget errorStatusImage(String statusCode) {
  String url = 'https://http.cat/$statusCode';
  return Image.network(url);
}
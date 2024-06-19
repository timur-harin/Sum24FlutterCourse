import 'package:flutter/material.dart';

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Страница не найдена'),
      ),
      body: Center(
        child: Text('Запрашиваемая страница не существует'),
      ),
    );
  }
}
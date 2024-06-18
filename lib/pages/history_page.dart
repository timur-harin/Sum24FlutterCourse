import 'package:contrast_shower_app/globaL/const.dart';
import 'package:contrast_shower_app/service/hive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    Provider.of<DataProvider>(context).loadDataFromHive();

    return Scaffold(
      backgroundColor: dark1,
      appBar: AppBar(
        backgroundColor: dark1,
        centerTitle: true,
        title: Text('История',style: wf24w600,),
      ),
      body: Center(
        child: Consumer<DataProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: center,
               children: provider.dataList.map((data) {
                return Text(
                  'Горячая т: ${data.warmtemp} '
                  'Холодная т: ${data.coldTemp} '
                  'Время: ${data.timer}',
                  style: wf14w600
                );
              }).toList(),
            );
                        },
        ),
      ),
    );
  }
}

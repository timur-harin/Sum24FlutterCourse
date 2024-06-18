import 'package:contrast_shower_app/service/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contrast_shower_app/globaL/const.dart';
import 'package:contrast_shower_app/widget/button.dart';
import 'package:contrast_shower_app/widget/textFiled.dart';
import 'package:contrast_shower_app/widget/number_picker.dart'; 

class TimerSettingsPage extends StatelessWidget {
  const TimerSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark1,
      body: Column(
        mainAxisAlignment: center,
        children: [
          Text('Таймер', style: wf24w600),
          Consumer<TimerAndTempModel>(
            builder: (context, timerAndtempModel, child) => Row(
              mainAxisAlignment: center,
              children: [
                IconButton(
                  onPressed: timerAndtempModel.decrementTime,
                  icon: Icon(Icons.remove, color: white),
                ),
                TextButton(
                  onPressed: () => _showTimePicker(context, timerAndtempModel),
                  child: Text(
                    '${timerAndtempModel.selectedHour.toString().padLeft(2, '0')}:${timerAndtempModel.selectedMinute.toString().padLeft(2, '0')}:${timerAndtempModel.selectedSecond.toString().padLeft(2, '0')}',
                    style: wf24w600,
                  ),
                ),
                IconButton(
                  onPressed: timerAndtempModel.incrementTime,
                  icon: Icon(Icons.add, color: white),
                ),
              ],
            ),
          ),
          Text('Горячая температура', style: wf24w600),
          Consumer<TimerAndTempModel>(
            builder: (context, timerAndtempModel, child) => Row(
              mainAxisAlignment: center,
              children: [
                IconButton(
                  onPressed: timerAndtempModel.decrementWarmTemp,
                  icon: Icon(Icons.remove, color: white),
                ),
                TextButton(
                  onPressed: () => _showTemperatureWarmPicker(context, timerAndtempModel),
                  child: Text('${timerAndtempModel.warmtemp.toString()}°C', style: wf24w600),
                ),
                IconButton(
                  onPressed: timerAndtempModel.incrementWarmTemp,
                  icon: Icon(Icons.add, color: white),
                ),
              ],
            ),
          ),
          Text('Холодная температура', style: wf24w600),
          Consumer<TimerAndTempModel>(
            builder: (context, timerAndtempModel, child) => Row(
              mainAxisAlignment: center,
              children: [  
                IconButton(
                  onPressed: timerAndtempModel.decrementColdTemp,
                  icon: Icon(Icons.remove, color: white),
                ),
                TextButton(
                  onPressed: () => _showTemperatureColdPicker(context, timerAndtempModel),
                  child: Text('${timerAndtempModel.coldtemp.toString()}°C', style: wf24w600),
                ),
                IconButton(
                  onPressed: timerAndtempModel.incrementColdTemp,
                  icon: Icon(Icons.add, color: white),
                ),
              ],
            ),
          ),
          MyButton(
            text: 'Начать',
            textColor: white,
            text_size: 24,
            text_weight: w600,
            color: primary,
            borderColor: primary,
            onTap: () {
              Navigator.pushNamed(context, 'timer_page');
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context, TimerAndTempModel timerAndtempModel) async {
    int tempHour = timerAndtempModel.selectedHour;
    int tempMinute = timerAndtempModel.selectedMinute;
    int tempSecond = timerAndtempModel.selectedSecond;

    final result = await showDialog<Map<String, int>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: primary,
              title: Text('Выберите время', style: wf24w600),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: center,
                      children: [
                        NumberPicker(
                          minValue: 0,
                          maxValue: 23,
                          value: tempHour,
                          onChanged: (value) {
                            setState(() {
                              tempHour = value;
                            });
                          },
                        ),
                        Text(':', style: wf24w600),
                        NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: tempMinute,
                          onChanged: (value) {
                            setState(() {
                              tempMinute = value;
                            });
                          },
                        ),
                        Text(':', style: wf24w600),
                        NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: tempSecond,
                          onChanged: (value) {
                            setState(() {
                              tempSecond = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text("OK", style: wf14w600),
                  onPressed: () {
                    Navigator.of(context).pop({
                      'hour': tempHour,
                      'minute': tempMinute,
                      'second': tempSecond,
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      timerAndtempModel.setTime(result['hour']!, result['minute']!, result['second']!);
    }
  }

  void _showTemperatureWarmPicker(BuildContext context, TimerAndTempModel timerAndtempModel) {
    final tempController = TextEditingController(text: timerAndtempModel.warmtemp.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primary,
          title: Text('Выберите температуру', style: wf24w600),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                MyTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Temp',
                  controller: tempController,
                  onChanged: (value) {
                    timerAndtempModel.setWarmTemp(int.parse(value));
                  },
                  color: white244,
                  textColor: black,
                ),
                ElevatedButton(
                  onPressed: () {
                    timerAndtempModel.setWarmTemp(int.parse(tempController.text));
                    Navigator.pop(context);
                  },
                  child: const Text('Выбрать'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showTemperatureColdPicker(BuildContext context, TimerAndTempModel timerAndtempModel) {
    final tempController = TextEditingController(text: timerAndtempModel.coldtemp.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primary,
          title: Text('Выберите температуру', style: wf24w600),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                MyTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Temp',
                  controller: tempController,
                  onChanged: (value) {
                    timerAndtempModel.setColdTemp(int.parse(value));
                  },
                  color: white244,
                  textColor: black,
                ),
                ElevatedButton(
                  onPressed: () {
                    timerAndtempModel.setColdTemp(int.parse(tempController.text));
                    Navigator.pop(context);
                  },
                  child: const Text('Выбрать'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

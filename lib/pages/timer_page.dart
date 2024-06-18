import 'package:contrast_shower_app/service/hive_provider.dart';
import 'package:flutter/material.dart';
import 'package:contrast_shower_app/service/timer_provider.dart';
import 'package:contrast_shower_app/globaL/const.dart';
import 'package:contrast_shower_app/widget/button.dart';
import 'package:provider/provider.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  
 
  @override
  Widget build(BuildContext context) {

    TimerAndTempModel timerAndTempModel = Provider.of<TimerAndTempModel>(context);

    return Scaffold(
      backgroundColor: timerAndTempModel.isWarmMode ? red : blue,
      body: Padding(
        padding: a16,
        child: Column(
          mainAxisAlignment: center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: center,
                children: [
                  Consumer<TimerAndTempModel>(
                    builder: (context,timerAndTempModel, _){
                      return Text(
                              timerAndTempModel.isWarmMode ? '${timerAndTempModel.warmtemp.toString()}°C' : '${timerAndTempModel.coldtemp.toString()}°C',
                              style: wf100w600,
                              textAlign: TextAlign.center,
                              );
                    }
                  ),
                  Consumer<TimerAndTempModel>(
                    builder: (context, timerAndTempModel, _) {
                      return Text(
                        '${timerAndTempModel.selectedHour.toString().padLeft(2, '0')}:${timerAndTempModel.selectedMinute.toString().padLeft(2, '0')}:${timerAndTempModel.selectedSecond.toString().padLeft(2, '0')}',
                        style: wf32w600,
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Consumer<TimerAndTempModel>(
              builder: (context, timerAndTempModel, _) {
                return MyButton(
                  text: timerAndTempModel.isTimerRunning ? 'Пауза' : 'Возобновить',
                  textColor: white,
                  text_size: 24,
                  text_weight: w600,
                  color: dark1,
                  borderColor: dark1,
                  onTap: () {
                    timerAndTempModel.isTimerRunning
                        ? timerAndTempModel.pauseTimer()
                        : timerAndTempModel.startTimer();
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            MyButton(
              text: 'Завершить',
              textColor: white,
              text_size: 24,
              text_weight: w600,
              color: dark1,
              borderColor: dark1,
              onTap: () {
                // Преобразование времени в минуты
                int hoursInMinutes = timerAndTempModel.selectedHour * 60;
                int minutes = timerAndTempModel.selectedMinute;
                int secondsInMinutes = (timerAndTempModel.selectedSecond / 60).round();

                // Общее время в минутах
                int totalTimeInMinutes = hoursInMinutes + minutes + secondsInMinutes;

                Provider.of<DataProvider>(context, listen: false).saveDataToHive(
                  timerAndTempModel.warmtemp,
                  timerAndTempModel.coldtemp,
                  totalTimeInMinutes,
                );
                Navigator.pop(context);  
              },
            ),
          ],
        ),
      ),
    );
  }
}

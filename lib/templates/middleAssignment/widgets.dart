import 'package:education/templates/middleAssignment/models/session_model.dart';
import 'package:education/templates/middleAssignment/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'notifiers.dart';
import 'package:customizable_datetime_picker/date_picker_widget.dart';

class ShowerSessionWidget extends ConsumerWidget {
  final String _id;

  const ShowerSessionWidget(this._id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size appSize = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    Session session = ref.watch(showerSessionsProvider).getSession(id: _id);

    return SizedBox(
      width: appSize.width - padding.left - padding.right - 20,
      height: 70,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            )
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded),
            const SizedBox(width: 24),
            Text(
                session.date,
                textAlign: TextAlign.center
            ),
            const VerticalDivider(
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              width: 48,
            ),
            Expanded(
                child: Text(session.duration)
            )
          ],
        ),
      ),
    );
  }
}


class ShowerSessionListWidget extends ConsumerWidget {
  const ShowerSessionListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Wrap(
        direction: Axis.vertical,
        spacing: 10,
        children: ref.watch(showerSessionsProvider).sessions,
      ),
    );
  }
}

class StartPhaseChoiceWidget extends ConsumerWidget {
  const StartPhaseChoiceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 40,
            child: ElevatedButton(
                onPressed: ref.watch(startPhaseProvider) ? null : () {
                  ref.read(startPhaseProvider.notifier).state = true;
                  // showCustomTimePicker(context: context);
                },

                style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    )
                ),
                child: const Text("Cold")
            ),
          ),

          const SizedBox(width: 20),

          SizedBox(
            width: 80,
            height: 40,
            child: ElevatedButton(
                onPressed: !ref.watch(startPhaseProvider) ? null : () {
                  ref.read(startPhaseProvider.notifier).state = false;
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  )
                ),
                child: const Text("Hot")
            ),
          ),

        ],
      ),
    );
  }
}

class TimePickerWidget extends ConsumerWidget {
  const TimePickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SizedBox(
        height: 420,
        child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Select phase duration",
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              CustomizableTimePickerWidget(
                looping: true,
                initialTime: DateTime(DateTime.now().year),
                timeFormat: "mm:ss",
                pickerTheme: DateTimePickerTheme(
                  itemTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  backgroundColor: Colors.transparent,
                  itemHeight: 80,
                  pickerHeight: 300,
                  dividerTheme: DatePickerDividerTheme(
                      dividerColor: Theme.of(context).dividerColor,
                      thickness: 3,
                      height: 2
                  ),
                ),
                onChange: (dateTime, selectedIndex) {
                  ref.read(timePickerTimeProvider.notifier).state = dateTime;
                }
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {Navigator.of(context).pop();},
                          child: const Text("Confirm"))
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            ref.read(timePickerTimeProvider.notifier).state = DateTime(DateTime.now().year);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel")
                      )
                  )
                ],
              )
            ]
        ),
      )
    );
  }
}

void showCustomTimePicker({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => TimePickerWidget()
  );
}

class PhaseDurationWidget extends ConsumerWidget {
  const PhaseDurationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
        onPressed: () {showCustomTimePicker(context: context);},
        child: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.timer_outlined
              ),
              Text(DateFormat("mm:ss").format(ref.watch(timePickerTimeProvider))),

            ],
          ),

        )
    );
  }
}


class PhasesAmountWidget extends ConsumerWidget {
  const PhasesAmountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SizedBox(
      width: 40,
      child: TextField(
        controller: ref.watch(textInputControllerProvider),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}

class SessionSettingsWidget extends ConsumerWidget {
  const SessionSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                "Start phase",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            const StartPhaseChoiceWidget(),
            SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phase duration",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    PhaseDurationWidget(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phases amount",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    PhasesAmountWidget(),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ShowerSessionScreen()
                      )
                    );
                  },
                  child: const Text("Start sesstion")
              ),
            )
          ],
        ),
    );

  }

}

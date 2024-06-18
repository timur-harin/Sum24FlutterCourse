import 'package:education/templates/middleAssignment/models/session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifiers.dart';


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


class ShowerSessionList extends ConsumerWidget {
  const ShowerSessionList({super.key});

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
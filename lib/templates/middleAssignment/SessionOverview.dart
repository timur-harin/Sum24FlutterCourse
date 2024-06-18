import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/newShower.dart';

class Sessionoverview extends ConsumerStatefulWidget {
  const Sessionoverview({super.key});

  @override
  ConsumerState<Sessionoverview> createState() => _SessionoverviewState();
}

class _SessionoverviewState extends ConsumerState<Sessionoverview> {
  @override
  Widget build(BuildContext context) {
    final seconds = ref.read(secondsProvider) ?? 60;
    final temp = ref.read(temperatureProvider) ?? 15;
    return AlertDialog(
      title: Text('Owerview'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('time'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '$seconds',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('temperature'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '$temp',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('cansel')
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/new/SessionOverview/shoverProcess');
                    },
                    child: Text('ok')
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

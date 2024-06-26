<<<<<<< HEAD
=======
import 'package:education/templates/lab6/card.dart';
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
import 'package:education/templates/lab6/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
<<<<<<< HEAD
    final builder = GoldenBuilder.grid(
      columns: 1,
      widthToHeightRatio: 0.5,
    )..addScenario('Login Screen', MaterialApp(home: LoginScreen()));

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(1000, 2000), 
    );

    await screenMatchesGolden(tester, 'login_screen');
  });
}
=======
    final widget = ProfileCard(
      imageUrl: 'https://example.com/image.jpg',
      name: 'John Doe',
      description: 'Software Developer',
    );

    final builder = GoldenBuilder.column()..addScenario('Login screen', widget);

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: Size(1000, 2000),
    );

    // TODO fix to pass this using 'flutter test'

    await screenMatchesGolden(tester, 'login_screen');

    // Test using flutter test test/golden_test.dart
  });
}

class Scenario {
  const Scenario();
}
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc

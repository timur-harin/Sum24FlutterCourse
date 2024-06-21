import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ShowerSessionPreferences.dart';
import 'Notifiers.dart';

final sharedPrefsProvider = StateNotifierProvider<SharedPrefsProviderNotifier,
    List<String>>(
        (ref) => SharedPrefsProviderNotifier()
);

final showerSessionPrefsProvider = StateNotifierProvider<ShowerSessionPrefsNotifier,
    ShowerSessionPreferences?>(
        (ref) => ShowerSessionPrefsNotifier()
);

final initialPhaseProvider = StateNotifierProvider<InitialPhaseChooserNotifier, String>(
        (ref) => InitialPhaseChooserNotifier()
);

final feedbackProvider = StateNotifierProvider<FeedbackNotifier, int>(
        (ref) => FeedbackNotifier()
);

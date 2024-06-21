import 'package:education/templates/middleAssignment/views/shower_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hotPhaseProvider = StateProvider<String>((ref) => '3');
final coldPhaseProvider = StateProvider<String>((ref) => '1');
final cyclesProvider = StateProvider<String>((ref) => '3');

class UserPreferences extends ConsumerStatefulWidget {
  const UserPreferences({super.key});

  @override
  _UserPreferences createState() => _UserPreferences();
}

class _UserPreferences extends ConsumerState<UserPreferences> {
  final _hotPhaseController = TextEditingController(text: '3');
  final _coldPhaseController = TextEditingController(text: '1');
  final _cyclesController = TextEditingController(text: '3');

  @override
  void initState() {
    _hotPhaseController.addListener(_updateTotalTime);
    _coldPhaseController.addListener(_updateTotalTime);
    _cyclesController.addListener(_updateTotalTime);
    super.initState();
  }

  int get(TextEditingController controller) {
    final int value = int.tryParse(controller.text) ?? 0;
    return value;
  }

  void _updateTotalTime() {
    setState(() {});
  }

  @override
  void dispose() {
    // Remove the listeners
    _hotPhaseController.removeListener(_updateTotalTime);
    _coldPhaseController.removeListener(_updateTotalTime);
    _cyclesController.removeListener(_updateTotalTime);

    // Dispose the controllers
    _hotPhaseController.dispose();
    _coldPhaseController.dispose();
    _cyclesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, /// Prevents the widget from resizing when the keyboard appears
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Session Preferences',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        alignment: const Alignment(0.0, 0.15),
        children: [
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Consumer(builder: (context, ref, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final count = ref.watch(hotPhaseProvider);
                  _hotPhaseController.value = TextEditingValue(
                    text: count,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: count.length),
                    ),
                  );

                  final count1 = ref.watch(coldPhaseProvider);
                  _coldPhaseController.value = TextEditingValue(
                    text: count1,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: count1.length),
                    ),
                  );

                  final count3 = ref.watch(cyclesProvider);
                  _cyclesController.value = TextEditingValue(
                    text: count3,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: count3.length),
                    ),
                  );
                });

                return Text(
                  'Total time: ${(get(_hotPhaseController) + get(_coldPhaseController)) * get(_cyclesController)} min',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                );
              }),
            ),
          ),

          /// Hot Water Duration
          Positioned(
            top: 120,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: Consumer(builder: (context, ref, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final count = ref.watch(hotPhaseProvider);
                      _hotPhaseController.value = TextEditingValue(
                        text: count,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: count.length),
                        ),
                      );
                    });

                    return TextField(
                      controller: _hotPhaseController,
                      onChanged: (value) {
                        ref.read(hotPhaseProvider.notifier).state = value;
                      },
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        labelText: 'Hot Water (minutes)',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                              tooltip: 'Decrease by one minute',
                              onPressed: () {
                                ref
                                    .read(hotPhaseProvider.notifier)
                                    .update((state) {
                                  final int temp = int.tryParse(state) ?? 0;
                                  state =
                                      (temp > 0 ? temp - 1 : temp).toString();
                                  return state;
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.green,
                              tooltip: 'Increase by one minute',
                              onPressed: () {
                                ref
                                    .read(hotPhaseProvider.notifier)
                                    .update((state) {
                                  final int temp = int.tryParse(state) ?? 0;
                                  state = (temp + 1).toString();
                                  return state;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          /// Cold Water Duration
          Positioned(
            top: 200,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: Consumer(builder: (context, ref, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final count = ref.watch(coldPhaseProvider);
                      _coldPhaseController.value = TextEditingValue(
                        text: count,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: count.length),
                        ),
                      );
                    });

                    return TextField(
                      controller: _coldPhaseController,
                      onChanged: (value) {
                        ref.read(coldPhaseProvider.notifier).state = value;
                      },
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        labelText: 'Cold Water (minutes)',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                              tooltip: 'Decrease by one minute',
                              onPressed: () {
                                ref
                                    .read(coldPhaseProvider.notifier)
                                    .update((state) {
                                  final int temp = int.tryParse(state) ?? 0;
                                  state =
                                      (temp > 0 ? temp - 1 : temp).toString();
                                  return state;
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.green,
                              tooltip: 'Increase by one minute',
                              onPressed: () {
                                ref
                                    .read(coldPhaseProvider.notifier)
                                    .update((state) {
                                  final int temp = int.tryParse(state) ?? 0;
                                  state = (temp + 1).toString();
                                  return state;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          /// Number of Cycles
          Positioned(
            top: 280,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: Consumer(
                    builder: (context, ref, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final count = ref.watch(cyclesProvider);
                        _cyclesController.value = TextEditingValue(
                          text: count,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: count.length),
                          ),
                        );
                      });

                      return TextField(
                        controller: _cyclesController,
                        onChanged: (value) {
                          ref.read(cyclesProvider.notifier).state = value;
                        },
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          labelText: 'Number of Cycles',
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  iconSize: 20,
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: Colors.red,
                                  tooltip: 'Decrease by one minute',
                                  onPressed: () {
                                    ref
                                        .read(cyclesProvider.notifier)
                                        .update((state) {
                                      final int temp = int.tryParse(state) ?? 0;
                                      state = (temp > 1 ? temp - 1 : temp)
                                          .toString();
                                      return state;
                                    });
                                  }),
                              IconButton(
                                  iconSize: 20,
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: Colors.green,
                                  tooltip: 'Increase by one minute',
                                  onPressed: () {
                                    ref
                                        .read(cyclesProvider.notifier)
                                        .update((state) {
                                      final temp = int.tryParse(state) ?? 0;
                                      state = (temp + 1).toString();
                                      return state;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// Begin Session button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShowerSession()),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.green),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.all(13)), // Adjust padding as needed:
            ),
            child: const Text(
              'Begin Session',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
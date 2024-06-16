import 'package:education/templates/middleAssignment/storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final List<ShowerPhase> _phases = [];

  DateTime? _selectedDate;
  
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }


  void _addPhase() {
    final dialogFormKey = GlobalKey<FormState>();
    showDialog(
      context: context, 
      builder: (context) {
        final durationController = TextEditingController();
        String? selectedPhaseName;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
            title: const Text(
              'Add Phase',
              style: TextStyle(
                color: Color(0xFF24305E),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: dialogFormKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select temperature interval',
                        ),
                        value: selectedPhaseName,
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'hot',
                            child: Text(
                              'hot',
                              style: TextStyle(
                                color: Color(0xFFF76C6c),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'cold',
                            child: Text(
                              'cold',
                              style: TextStyle(
                                color: Color(0xFF374785),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedPhaseName = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a phase name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: durationController,
                        decoration: const InputDecoration(
                          labelText: 'Duration (in minutes)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a duration';
                          }
                          final int? parsedValue = int.tryParse(value);
                          if (parsedValue == null || parsedValue <= 0) {
                            return 'Please enter a duration';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.canPop(context) ? Navigator.pop(context) : null;
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF24305E),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (dialogFormKey.currentState!.validate()) {
                          final name = selectedPhaseName;
                          final duration = int.tryParse(durationController.text) ?? 0;
                          if (name != null && duration > 0) {
                            setState(() {
                              final newPhase = ShowerPhase(name: name, duration: Duration(minutes: duration));
                              Navigator.of(context).pop(newPhase);
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Color(0xFF24305E),
                        ),
                      ),
                    ),
                  ],
            );
          },
        );
      },
    ).then((newPhase) {
      if (newPhase != null) {
        setState(() {
          _phases.add(newPhase);
        });
      }
    });
  }

void _saveSession(BuildContext context) async {
  if (_phases.isEmpty) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            color: Color(0xFF24305E),
          ),  
        ),
        content: const Text(
          'Please add at least one phase before saving the session.',
          style: TextStyle(
            color: Color(0xFF24305E),
          ),  
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF24305E),
              ),
            ),
          ),
        ],
      ),
    );
    return;
  }

  try {
    ShowerSession session = ShowerSession(date: _selectedDate!, phases: _phases);
    LocalStorageService localStorageService = LocalStorageService();
    List<ShowerSession> sessions = await localStorageService.getSessions();
    sessions.add(session);
    await localStorageService.saveSessions(sessions);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Success',
          style: TextStyle(
            color: Color(0xFF24305E),
          ),
        ),
        content: const Text(
          'The session has been saved successfully.',
          style: TextStyle(
            color: Color(0xFF24305E),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {

              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF24305E),
              ),
            ),
          ),
        ],
      ),
    );
    
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            color: Color(0xFF24305E),
          ),
        ),
        content: Text(
          'Failed to save the session: $e',
          style: const TextStyle(
            color: Color(0xFF24305E),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF24305E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Session'),
        backgroundColor: const Color(0xFF24305E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                      _dateController.text = DateFormat('dd/MM/yyyy').format(date);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: _addPhase,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF24305E)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Add Phase'),
              ),
              const SizedBox(height: 16.0,),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: _phases.length,
                  itemBuilder: (context, index) {
                    final phase = _phases[index];
                    return ListTile(
                      title: Text(
                        phase.name,
                        style: TextStyle(
                              color: phase.name == 'hot' 
                              ? const Color(0xFFF76C6c) 
                              : const Color(0xFF374785),
                        ),
                      ),
                      subtitle: Text('${phase.duration.inMinutes} minutes'),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveSession(context);
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF24305E)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                child: const Text('Save Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:education/templates/middleAssignment/storage.dart';
import 'package:flutter/material.dart';

class AddSessionScreen extends StatefullWidget {
  const AddSessionScreen({Key? key}) : super(key: key);

  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final List<ShowerPhase> _phases = [];

  DateTime? _selectedDate;
}
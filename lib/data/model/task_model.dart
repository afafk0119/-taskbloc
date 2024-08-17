import 'package:equatable/equatable.dart';

class Task {
  final String name;
  final String description;
  final String assignedEmployee;

  Task({
    required this.name,
    required this.description,
    required this.assignedEmployee,
  });
}

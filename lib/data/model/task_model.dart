import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String name;
  final String description;
  final String assignedEmployee;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.assignedEmployee,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      assignedEmployee: json['assignedEmployee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'assignedEmployee': assignedEmployee,
    };
  }

  @override
  List<Object?> get props => [id, name, description, assignedEmployee];
}

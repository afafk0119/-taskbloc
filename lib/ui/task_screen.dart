import 'package:bloc_task/bloc/task%20_bloc.dart';
import 'package:bloc_task/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/task_event.dart';
import 'package:lottie/lottie.dart';

class TaskCreationScreen extends StatefulWidget {
  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedEmployee;

  final List<String> _employees = [
    'Alice Johnson',
    'Bob Smith',
    'Charlie Davis',
    'Diana Garcia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Header

                  Center(
                    child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Lottie.asset('assets/lottietest.json')),
                  ),

                  // Task Name Field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.task),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Task Description Field
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Task Description',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Employee Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedEmployee,
                    hint: Text('Assign to Employee'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    items: _employees.map((String employee) {
                      return DropdownMenuItem<String>(
                        value: employee,
                        child: Text(employee),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedEmployee = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an employee';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),

                  // Create Task Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final task = Task(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            assignedEmployee: _selectedEmployee ?? '',
                          );
                          BlocProvider.of<TaskBloc>(context)
                              .add(CreateTask(task));
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Create Task',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

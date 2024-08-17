import 'package:bloc_task/bloc/task%20_bloc.dart';
import 'package:bloc_task/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/task_event.dart';

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
  ]; // Replace with dynamic data if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the task list screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Task Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedEmployee,
                hint: Text('Select Employee'),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      assignedEmployee: _selectedEmployee ?? '',
                    );
                    BlocProvider.of<TaskBloc>(context).add(CreateTask(task));
                    Navigator.pop(
                        context); // Navigate back to the task list after creation
                  }
                },
                child: Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

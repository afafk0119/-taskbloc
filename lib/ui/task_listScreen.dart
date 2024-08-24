import 'package:bloc_task/bloc/bloc_state.dart';
import 'package:bloc_task/bloc/task%20_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadSuccess) {
            if (state.tasks.isEmpty) {
              return Center(child: Text('No tasks available.'));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${task.description}'),
                        Text('Assigned to: ${task.assignedEmployee}'),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          } else if (state is TaskLoadFailure) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text('Welcome! Start by creating a task.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: Icon(Icons.add),
        tooltip: 'Create Task',
      ),
    );
  }
}

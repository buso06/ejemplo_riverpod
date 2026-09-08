import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(String title) {
    if (title.trim().isEmpty) return;

    state = [
      ...state,
      Task(title: title.trim()),
    ];
  }

  void toggleTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(
            completed: !state[i].completed,
          )
        else
          state[i],
    ];
  }

  void deleteTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}

final taskProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
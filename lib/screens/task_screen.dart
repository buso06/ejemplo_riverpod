import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/task_provider.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = _taskController.text;

    if (title.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escriba una tarea'),
        ),
      );
      return;
    }

    ref.read(taskProvider.notifier).addTask(title);

    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);

    final total = tasks.length;
    final completed = tasks.where((task) => task.completed).length;
    final pending = total - completed;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total',
                    value: total,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    title: 'Pendientes',
                    value: pending,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    title: 'Completadas',
                    value: completed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Nueva tarea',
                      hintText: 'Ej: Estudiar para el quiz',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Agregar'),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay tareas registradas',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: task.completed,
                              onChanged: (_) {
                                ref
                                    .read(taskProvider.notifier)
                                    .toggleTask(index);
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              task.completed
                                  ? 'Completada'
                                  : 'Pendiente',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Eliminar',
                              onPressed: () {
                                ref
                                    .read(taskProvider.notifier)
                                    .deleteTask(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Text(
              '$value',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
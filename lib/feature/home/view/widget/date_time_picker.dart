import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../view_model/state/provider/todo_provider.dart';

class DateTimePicker extends ConsumerStatefulWidget {
  const DateTimePicker({super.key});

  @override
  ConsumerState<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends ConsumerState<DateTimePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    var todo = ref.watch(fetchedTodoNotifierProvider.notifier);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      todo.updateDeadline(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    var todo = ref.watch(fetchedTodoNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Deadline: ${todo.deadline!.day} ${todo.deadline!.month} ${todo.deadline!.year}',
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Deadline'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

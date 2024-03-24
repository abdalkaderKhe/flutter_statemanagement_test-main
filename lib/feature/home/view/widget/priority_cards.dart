import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import '../../view_model/state/provider/todo_provider.dart';

final class PriorityCards extends ConsumerWidget {
  const PriorityCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoNotifier = ref.watch(fetchedTodoNotifierProvider.notifier);
    var todo = ref.watch(fetchedTodoNotifierProvider);
    Widget buildSelectableCard(String text) {
      return InkWell(
        onTap: () {
          todoNotifier.updatePriority(text);
        },
        child: SizedBox(
          height: context.dynamicHeight(0.1),
          width: context.dynamicWidth(0.2),
          child: Card(
            color: todo.priority == text ? Colors.blue : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    color: todo.priority == text ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildSelectableCard('high'),
        buildSelectableCard('medium'),
        buildSelectableCard('low'),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import '../../../../../core/ui/component/column/spacer_column.dart';
import '../../../../../core/ui/component/row/spacer_row.dart';
import '../../../../auth/view/widget/main_button.dart';
import '../../../view_model/state/provider/todo_provider.dart';
import '../date_time_picker.dart';
import '../priority_cards.dart';

final class AddTodoDialog {
  final BuildContext context;

  AddTodoDialog({required this.context});

  void show() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: context.dynamicHeight(0.8),
            width: context.dynamicWidth(0.8),
            child: DialogForm(),
          ),
        );
      },
    );
  }
}

final class DialogForm extends ConsumerWidget {
  DialogForm({super.key});

  final TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todo = ref.watch(fetchedTodoNotifierProvider);

    var todoNotifier = ref.watch(fetchedTodoNotifierProvider.notifier);

    final homeStateNotifier = ref.read(homeStateNotifierProvider.notifier);

    textEditingController.text = todo.activity ?? '';

    return Form(
      key: formKey,
      child: Center(
        child: SpacerRow(
          spacerFlexValue: 1,
          bodyFlexValue: 10,
          child: SpacerColumn(
            spacerFlexValue: 1,
            bodyFlexValue: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: textEditingController,
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      todoNotifier.updateActive(textEditingController.text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Todo Description',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.grey.shade300),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Todo description is required ";
                      return null;
                    },
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: PriorityCards(),
                ),
                const Expanded(
                  flex: 3,
                  child: DateTimePicker(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox.shrink(),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      todoNotifier.updateNote(value);
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Note',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MainButton(
                    title: 'AddTodo',
                    onTap: () async {
                      if (formKey.currentState!.validate() && todo.priority != null)
                      {
                        formKey.currentState!.save();
                        await homeStateNotifier.addTodo(todo);
                        ref.read(homeStateNotifierProvider.notifier).closeDialogsFlow();
                      }
                      else if (todo.priority == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('specifying task priority is required '),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

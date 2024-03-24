import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../model/todo.dart';

final class FetchedTodoNotifier extends StateNotifier<Todo> {
  FetchedTodoNotifier() : super(Todo.initial());

  void update(Todo todo) {
    state = todo;
  }

  void updateActive(String value) {
    final todo = state;
    todo.activity = value;
    state = todo;
  }

  void updatePriority(String value) {
    state = state.copyWith(priority: value);
  }

  void updateTitle(String value) {
    state = state.copyWith(activity: value);
  }

  void updateDeadline(DateTime value) {
    state = state.copyWith(deadline: value);
  }

  void updateNote(String value) {
    state = state.copyWith(note: value);
  }
}

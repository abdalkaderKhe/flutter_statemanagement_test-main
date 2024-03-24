import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../model/todo.dart';
import '../model/hoem_state_model.dart';
import '../provider/todo_provider.dart';

final class HomeStateNotifier extends StateNotifier<HomeStateModel> {
  late final Ref ref;

  HomeStateNotifier(this.ref) : super(HomeStateModel.init());

  Future<void> init() async {
    final result = await ref.refresh(fetchTodoProvider.future);
    result.when(success: (value) {
      ref.read(homeStateNotifierProvider.notifier).displayVerifyDialog();
    }, failure: (value) {
      ref.read(homeStateNotifierProvider.notifier).displayErrorSnackBar(value);
    });

  }

  Future<void> fetchLocalTodos() async {
    List<Todo> todos = [];
    final homeViewMode = ref.read(homeViewModelProvider);
    todos = await homeViewMode.fetchLocalTodos();
    state = state.copyWith(todos: todos);
  }

  Future<void> toggle(
    int index,
    bool value,
  ) async {
    final homeViewMode = ref.read(homeViewModelProvider);
    await homeViewMode.updateTodoStatus(index, value, state.todos);
    await fetchLocalTodos();
  }

  Future<void> addTodo(Todo todo) async {
    final homeViewMode = ref.watch(homeViewModelProvider);
    await homeViewMode.saveTodo(todo);
    await fetchLocalTodos();
    closeDialogsFlow();
  }

  void displayVerifyDialog() {
    state = state.copyWith(
      showVerifyDialog: true,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: false,
    );
  }

  void displayFetchDialog() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: true,
      showErrorSnackBar: false,
      closeDialogsFlow: false,
    );
  }

  void displayTodoFormDialog() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: true,
      showFetchDialog: false,
      showErrorSnackBar: false,
      closeDialogsFlow: false,
    );
  }

  void displayErrorSnackBar(String value) {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: true,
      closeDialogsFlow: false,
      errorMsg: value,
    );
  }

  void closeDialogsFlow() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: false,
      closeDialogsFlow: true,
    );
  }
}

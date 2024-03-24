import '../../../model/todo.dart';

final class HomeStateModel {
  List<Todo> todos;
  bool showVerifyDialog;
  bool showTodoFormDialog;
  bool showFetchDialog;
  bool showErrorSnackBar;
  bool closeDialogsFlow;
  String? errorMsg;

  HomeStateModel({
    this.todos = const [],
    this.showVerifyDialog = false,
    this.showTodoFormDialog = false,
    this.showFetchDialog = false,
    this.showErrorSnackBar = false,
    this.closeDialogsFlow = false,
    this.errorMsg,
  });

  factory HomeStateModel.init() => HomeStateModel();

  HomeStateModel copyWith({
    List<Todo>? todos,
    bool? showVerifyDialog,
    bool? showTodoFormDialog,
    bool? showFetchDialog,
    bool? showErrorSnackBar,
    bool? closeDialogsFlow,
    String? errorMsg,
  }) {
    return HomeStateModel(
      todos: todos ?? this.todos,
      showVerifyDialog: showVerifyDialog ?? this.showVerifyDialog,
      showTodoFormDialog: showTodoFormDialog ?? this.showTodoFormDialog,
      showFetchDialog: showFetchDialog ?? this.showFetchDialog,
      showErrorSnackBar: showErrorSnackBar ?? this.showErrorSnackBar,
      closeDialogsFlow: closeDialogsFlow ?? this.closeDialogsFlow,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/feature/home/view/home_view.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/add_todo_form_dilog.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/fetch_todo_dialgo.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/verify_dialog.dart';
import '../view_model/state/model/hoem_state_model.dart';
import '../view_model/state/provider/todo_provider.dart';

mixin HomeViewMixin on ConsumerState<HomeView> {
  @override
  void initState() {
    ref.read(homeStateNotifierProvider.notifier).init();
    super.initState();
  }

  void runDialogsFlow() {
    ref.listen<HomeStateModel>(homeStateNotifierProvider, (previous, current) {
      if (current.showVerifyDialog) {
        ref.watch(fetchTodoProvider);
        VerifyDialog(
          context: context,
        ).show();
      } else if (current.showFetchDialog) {
        FetchTodoDialog(
          context: context,
        ).show();
      } else if (current.showTodoFormDialog) {
        AddTodoDialog(
          context: context,
        ).show();
      } else if (current.closeDialogsFlow) {
        current.closeDialogsFlow = false;
        context.pop();
      } else if (current.showErrorSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(current.errorMsg!),
        ));
      }
    });
  }
}

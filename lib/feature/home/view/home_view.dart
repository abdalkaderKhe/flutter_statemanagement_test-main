import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import 'package:state_management_test/core/ui/component/row/spacer_row.dart';
import 'package:state_management_test/feature/home/view/home_view_mixin.dart';
import 'package:state_management_test/feature/home/view/widget/todo_card_item.dart';
import '../../../core/router/router_notifier.dart';
import '../../auth/view_model/state/provider/auth_providers.dart';
import '../view_model/state/provider/todo_provider.dart';

class HomeView extends ConsumerStatefulWidget
{
  const HomeView({super.key});
  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with HomeViewMixin
{
  @override
  Widget build(BuildContext context)
  {

    runDialogsFlow();

    final homeStateNotifier = ref.watch(homeStateNotifierProvider.notifier);

    final homeState = ref.watch(homeStateNotifierProvider);

    return Scaffold(

      appBar: AppBar(title: const Text('Home Page'),),

      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            const SizedBox(height: 100,),

            InkWell(
              onTap: () async {
                await ref.read(authStateProvider.notifier).logOut();
                ref.read(routerNotifierProvider).pushLogin = true;
              },
              child: const Text('LogOut'),
            ),

          ],
        ),
      ),

      body: ref.watch(fetchLocalTodosProvider).when(
        data: (results) => SpacerRow(spacerFlexValue: 1, bodyFlexValue: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              const Text('Active Todos'),
              SizedBox(
                height: context.dynamicHeight(0.4),
                width: context.dynamicWidth(1),
                child: ListView.builder(
                  itemCount: homeState.todos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return !homeState.todos[index].isDone! ? SizedBox(
                      height: context.dynamicHeight(0.18),
                      child: TodoCardItem(todo: homeState.todos[index], onChanged: (value) async { await homeStateNotifier.toggle(index, value!);},),
                    ) : const SizedBox.shrink();
                  },
                ),
              ),

              const Text('Completed Todos'),
              SizedBox(
                height: context.dynamicHeight(0.4),
                width: context.dynamicWidth(1),
                child: ListView.builder(
                  itemCount: homeState.todos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return homeState.todos[index].isDone! ? SizedBox(
                      height: context.dynamicHeight(0.18),
                      child: TodoCardItem(todo: homeState.todos[index], onChanged: (value) async { await homeStateNotifier.toggle(index, value!);},),
                    ) : const SizedBox.shrink();
                  },
                ),
              ),

            ],
          ),
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}


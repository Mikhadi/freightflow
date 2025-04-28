import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freiightflow/newHomePage/presentation/widgets/grid_buttons.dart';
import 'package:freiightflow/newHomePage/presentation/widgets/new_app_bar.dart';
import 'package:freiightflow/newHomePage/presentation/widgets/search_bar.dart';
import 'package:freiightflow/newHomePage/providers/user_provider.dart';

class NewHomePage extends ConsumerStatefulWidget {
  const NewHomePage({super.key});

  @override
  ConsumerState<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends ConsumerState<NewHomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(userProvider.notifier).loadUser('test_token');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final date = DateTime.now();

    return Scaffold(
      drawer: user.isAdmin ? Drawer() : null,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewAppbar(), 
            const SizedBox(height: 25), 
            Text("${date.day.toString()} ${date.month.toString()}"),
            const SizedBox(height: 25), 
            MySearchBar(),
            const SizedBox(height: 25),
            Expanded(child: GridButtons()),
          ],
        ),
      ),
    );
  }
}

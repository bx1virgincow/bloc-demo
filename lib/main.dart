import 'package:bloc_demo/di.dart';
import 'package:bloc_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/presentation/page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //call di
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(GetTodoEvent()),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

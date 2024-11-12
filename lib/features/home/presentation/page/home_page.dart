import 'package:bloc_demo/di.dart';
import 'package:bloc_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_demo/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc homeBloc;
  late bool isDeleting;
  @override
  void initState() {
    super.initState();
    homeBloc = sl<HomeBloc>()..add(GetTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.isLoading) {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } 
            // else if (state.deleteItemId != null) {
            //   Navigator.pop(context);
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text('Todo Deleted Successfully')),
            //   );
            // }
          },
          builder: (context, state) {
            if (state.isLoading && state.todos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }
        
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final item = state.todos[index];
                return ListTile(
                  title: Text(item.title.toString()),
                  subtitle: Text(item.body.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(DeleteTodoEvent(item.id.toString()));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

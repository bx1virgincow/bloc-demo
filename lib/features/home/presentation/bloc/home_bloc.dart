import 'dart:async';
import 'package:bloc_demo/features/home/data/model/todo_model.dart';
import 'package:bloc_demo/features/home/domain/usecase/delete_todo_usecase.dart';
import 'package:bloc_demo/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_demo/features/home/domain/usecase/get_todos_usecase.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTodosUsecase getTodosUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;

  List<TodoModel> currentTodos = [];

  HomeBloc({
    required this.getTodosUsecase,
    required this.deleteTodoUsecase,
  }) : super(const HomeState()) {
    on<GetTodoEvent>(_onGetTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }

  // FutureOr<void> _onGetTodoEvent(
  //     GetTodoEvent event, Emitter<HomeState> emit) async {
  //   emit(ReadLoadingState());
  //   final results = await getTodosUsecase(NoParams());
  //   results.fold((error) {
  //     emit(HomeErrorState(message: error.errorMessage));
  //   }, (data) {
  //     emit(ReadSuccessState(data));
  //   });
  // }

  // FutureOr<void> _onDeleteTodoEvent(
  //     DeleteTodoEvent event, Emitter<HomeState> emit) async {
  //   emit(DeleteLoadingState(itemId: event.todoId));
  //   await Future.delayed(const Duration(seconds: 5));
  //   final results = await deleteTodoUsecase(DeleteTodoParam(event.todoId));
  //   log('Bloc results: $results');
  //   await results.fold((error) {
  //     emit(DeleteErrorState(message: error.errorMessage));
  //   }, (success) async {
  //     log('success');
  //     emit(DeleteSuccessState(event.todoId));
  //     //obtain data again
  //     final updateTodo = await getTodosUsecase(NoParams());
  //     updateTodo.fold((error)async {
  //       emit(ReadErrorState(message: error.errorMessage));
  //     }, (updateData) async{
  //       emit(ReadSuccessState(updateData));
  //     });
  //   });
  // }

  Future<void> _onGetTodoEvent(
      GetTodoEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    final results = await getTodosUsecase(NoParams());
    results.fold(
      (error) => emit(
          state.copyWith(isLoading: false, errorMessage: error.errorMessage)),
      (data) => emit(state.copyWith(isLoading: false, todos: data)),
    );
  }

  Future<void> _onDeleteTodoEvent(
      DeleteTodoEvent event, Emitter<HomeState> emit) async {
    // Start by emitting the loading state
    emit(state.copyWith(isDeleting: true, deleteItemId: event.todoId));

    // Await the deletion operation
    final results = await deleteTodoUsecase(DeleteTodoParam(event.todoId));

    await results.fold(
      (error) async {
        // If there's an error, emit the error state
        emit(
            state.copyWith(isDeleting: false, errorMessage: error.errorMessage));
      },
      (_) async {
        // If deletion is successful, refresh the todo list
        final updatedResults = await getTodosUsecase(NoParams());

        await updatedResults.fold(
          (error) async {
            // Emit error if fetching updated todos fails
            emit(state.copyWith(
                isDeleting: false, errorMessage: error.errorMessage));
          },
          (updatedTodos) async {
            // Emit success with the updated list of todos
            emit(state.copyWith(isDeleting: false, todos: updatedTodos));
          },
        );
      },
    );
  }
}

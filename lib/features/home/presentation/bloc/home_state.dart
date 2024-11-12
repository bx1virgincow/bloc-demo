// import 'package:bloc_demo/features/home/data/model/todo_model.dart';
// import 'package:equatable/equatable.dart';

// abstract class HomeState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// // General states
// class InitialHomeState extends HomeState {}

// class CrudErrorState extends HomeState {
//   final String errorMessage;
//   CrudErrorState(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }

// // Read Operation
// class ReadLoadingState extends HomeState {}

// class ReadErrorState extends HomeState {
//   final String message;
//   ReadErrorState({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// class ReadSuccessState extends HomeState {
//   final List<TodoModel> items;
//   ReadSuccessState(this.items);

//   @override
//   List<Object> get props => [items];
// }

// // Create Operation
// class CreateLoadingState extends HomeState {}

// class CreateSuccessState extends HomeState {
//   final String message;
//   CreateSuccessState(this.message);

//   @override
//   List<Object> get props => [message];
// }

// // Update Operation
// class UpdateLoadingState extends HomeState {}

// class UpdateSuccessState extends HomeState {
//   final String message;
//   UpdateSuccessState(this.message);

//   @override
//   List<Object> get props => [message];
// }

// // Delete Operation
// class DeleteLoadingState extends HomeState {
//   final String itemId;
//   DeleteLoadingState({required this.itemId});

//   @override
//   List<Object> get props => [itemId];
// }

// class DeleteErrorState extends HomeState {
//   final String message;
//   DeleteErrorState({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// class DeleteSuccessState extends HomeState {
//   final String itemId;
//   DeleteSuccessState(this.itemId);

//   @override
//   List<Object> get props => [itemId];
// }

// //
// class HomeErrorState extends HomeState {
//   final String message;
//   HomeErrorState({required this.message});

//   @override
//   List<Object> get props => [message];
// }

import 'package:bloc_demo/features/home/data/model/todo_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<TodoModel> todos;
  final bool isLoading;
  final bool isDeleting;
  final String? errorMessage;
  final String? deleteItemId;

  const HomeState({
    this.todos = const [],
    this.isLoading = false,
    this.isDeleting = false,
    this.errorMessage,
    this.deleteItemId,
  });

  HomeState copyWith({
    List<TodoModel>? todos,
    bool? isLoading,
    bool? isDeleting,
    String? errorMessage,
    String? deleteItemId,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      isDeleting: isDeleting ?? this.isDeleting,
      errorMessage: errorMessage ?? this.errorMessage,
      deleteItemId: deleteItemId ?? this.deleteItemId,
    );
  }

  @override
  List<Object?> get props => [
        todos,
        isLoading,
        isDeleting,
        errorMessage,
        deleteItemId,
      ];
}

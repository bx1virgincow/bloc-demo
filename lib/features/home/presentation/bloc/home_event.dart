part of 'home_bloc.dart';

sealed class HomeEvent{
  const HomeEvent();
}

class GetTodoEvent extends HomeEvent{
  
}

class DeleteTodoEvent extends HomeEvent{
  final String todoId;
  const DeleteTodoEvent(this.todoId);
}
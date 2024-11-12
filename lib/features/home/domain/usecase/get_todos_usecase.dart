import 'package:bloc_demo/core/results.dart';
import 'package:bloc_demo/features/home/data/model/todo_model.dart';
import 'package:bloc_demo/features/home/domain/repository/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<FailureResults, Type>> call(Params params);
}

class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}

class DeleteTodoParam extends Equatable{
  final String id;
  const DeleteTodoParam(this.id);

  @override
  List<Object> get props=>[id];
}


class GetTodosUsecase extends UseCase<List<TodoModel>, NoParams>{
  final HomeRepo homeRepository;
  GetTodosUsecase({required this.homeRepository});
  
  @override
  Future<Either<FailureResults, List<TodoModel>>> call(NoParams params) {
    return homeRepository.getNote();
  }

  
}
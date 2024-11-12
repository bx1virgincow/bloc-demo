import 'package:bloc_demo/core/results.dart';
import 'package:bloc_demo/features/home/domain/repository/home_repo.dart';
import 'package:bloc_demo/features/home/domain/usecase/get_todos_usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoUsecase extends UseCase<void, DeleteTodoParam> {
  final HomeRepo homeRepository;
  DeleteTodoUsecase({required this.homeRepository});

  @override
  Future<Either<FailureResults, void>> call(DeleteTodoParam params) {
    return homeRepository.deleteNote(params.id);
  }
}

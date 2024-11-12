import 'package:bloc_demo/core/results.dart';
import 'package:bloc_demo/features/home/data/model/todo_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<FailureResults, List<TodoModel>>> getNote();
  Future<Either<FailureResults, void>> deleteNote(String id);
}

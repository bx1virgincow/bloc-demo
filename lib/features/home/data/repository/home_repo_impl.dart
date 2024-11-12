import 'dart:developer';

import 'package:bloc_demo/core/results.dart';
import 'package:bloc_demo/features/home/data/model/todo_model.dart';
import 'package:bloc_demo/features/home/data/source/remote.dart';
import 'package:bloc_demo/features/home/domain/repository/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteSource remoteSource;

  HomeRepoImpl({required this.remoteSource});

  @override
  Future<Either<FailureResults, void>> deleteNote(String id) async {
    try {
      await remoteSource.deleteTodo(id);
      log('i made it here... ');
      return const Right(null);
    } catch (e) {
      log('here I am... ${e.toString()}');
      return Left(FailureResults(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<FailureResults, List<TodoModel>>> getNote() async {
    try {
      final results = await remoteSource.getTodos();
      return Right(results);
    } catch (e) {
      return Left(FailureResults(errorMessage: e.toString()));
    }
  }
}

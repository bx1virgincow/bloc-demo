import 'package:bloc_demo/features/home/data/repository/home_repo_impl.dart';
import 'package:bloc_demo/features/home/data/source/remote.dart';
import 'package:bloc_demo/features/home/domain/repository/home_repo.dart';
import 'package:bloc_demo/features/home/domain/usecase/delete_todo_usecase.dart';
import 'package:bloc_demo/features/home/domain/usecase/get_todos_usecase.dart';
import 'package:bloc_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  //blocs
  sl.registerFactory<HomeBloc>(() => HomeBloc(
        getTodosUsecase: sl<GetTodosUsecase>(),
        deleteTodoUsecase: sl<DeleteTodoUsecase>(),
      ));

  //repositories
  sl.registerLazySingleton<HomeRemoteSource>(() => HomeRemoteSourceImpl());
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(
        remoteSource: sl<HomeRemoteSource>(),
      ));

  //usecases
  sl.registerLazySingleton(() => GetTodosUsecase(
        homeRepository: sl<HomeRepo>(),
      ));
  sl.registerLazySingleton<DeleteTodoUsecase>(() => DeleteTodoUsecase(
        homeRepository: sl<HomeRepo>(),
      ));
}

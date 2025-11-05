import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mapping/core/core.dart';

typedef Result<T> = Either<AppException, T>;

typedef BaseCubit<T> = Cubit<T>;

import 'package:aplazo_pt/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultFutureList<T> = Future<Either<Failure, List<T>>>;
typedef DataMap = Map<String, dynamic>;

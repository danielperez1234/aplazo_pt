import 'package:aplazo_pt/core/utils/typedefs.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();
  ResultFuture<T> call();
}

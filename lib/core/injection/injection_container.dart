import 'dart:developer';

import 'package:aplazo_pt/features/serch_by_name/search_by_name_injection.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  log('Registering core dependencies...');
  sl.registerLazySingleton<Dio>(() => Dio());

  log('Registering feature: serch_by_Name');
  searchByNameInjection(sl);
}

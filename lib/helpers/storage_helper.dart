import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

class StorageHelper {
  static void write(String key, dynamic value) =>
      HydratedBloc.storage.write(key, jsonEncode(value));

  static dynamic read(String key) => HydratedBloc.storage.read(key);

  static bool exists(String key) => HydratedBloc.storage.read(key) != null;

  static void delete(String key) => HydratedBloc.storage.delete(key);

  static void clearAll() => HydratedBloc.storage.clear();
}

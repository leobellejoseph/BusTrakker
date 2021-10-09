import 'dart:core';

import 'package:equatable/equatable.dart';

class SelectedRoute extends Equatable {
  final String code;
  final String service;
  const SelectedRoute({required this.code, required this.service});
  @override
  List<Object?> get props => [this.code, this.service];
}

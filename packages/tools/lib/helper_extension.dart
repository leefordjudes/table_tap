part of 'tools.dart';

extension OptionalStringHelpers<E> on String? {
  /// Checks the value is null
  bool get isNull => this == null;

  /// Checks the value is null
  bool get isNotNull => this != null;

  /// Checks the value is null / empty
  bool get isNullOrEmpty => isNull || this!.isEmpty;

  /// Checks the value is null / empty
  bool get isNotNullOrEmpty => isNotNull && this!.isNotEmpty;
}

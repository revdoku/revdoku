//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailAssignmentError {
  /// Returns a new [MailboxEmailAssignmentError] instance.
  MailboxEmailAssignmentError({
    this.code,
    this.message,
    this.retryable,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? code;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? retryable;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailAssignmentError &&
    other.code == code &&
    other.message == message &&
    other.retryable == retryable;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code == null ? 0 : code!.hashCode) +
    (message == null ? 0 : message!.hashCode) +
    (retryable == null ? 0 : retryable!.hashCode);

  @override
  String toString() => 'MailboxEmailAssignmentError[code=$code, message=$message, retryable=$retryable]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.code != null) {
      json[r'code'] = this.code;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    }
    if (this.retryable != null) {
      json[r'retryable'] = this.retryable;
    }
    return json;
  }

  /// Returns a new [MailboxEmailAssignmentError] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailAssignmentError? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxEmailAssignmentError(
        code: mapValueOfType<String>(json, r'code'),
        message: mapValueOfType<String>(json, r'message'),
        retryable: mapValueOfType<bool>(json, r'retryable'),
      );
    }
    return null;
  }

  static List<MailboxEmailAssignmentError> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailAssignmentError>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailAssignmentError.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailAssignmentError> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailAssignmentError>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailAssignmentError.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailAssignmentError-objects as value to a dart map
  static Map<String, List<MailboxEmailAssignmentError>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailAssignmentError>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailAssignmentError.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


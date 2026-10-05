//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailAssignment {
  /// Returns a new [MailboxEmailAssignment] instance.
  MailboxEmailAssignment({
    this.id,
    this.status,
    this.hostname,
    this.error,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  MailboxEmailAssignmentStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hostname;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxEmailAssignmentError? error;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailAssignment &&
    other.id == id &&
    other.status == status &&
    other.hostname == hostname &&
    other.error == error;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (hostname == null ? 0 : hostname!.hashCode) +
    (error == null ? 0 : error!.hashCode);

  @override
  String toString() => 'MailboxEmailAssignment[id=$id, status=$status, hostname=$hostname, error=$error]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    }
    if (this.hostname != null) {
      json[r'hostname'] = this.hostname;
    }
    if (this.error != null) {
      json[r'error'] = this.error;
    }
    return json;
  }

  /// Returns a new [MailboxEmailAssignment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailAssignment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxEmailAssignment(
        id: mapValueOfType<String>(json, r'id'),
        status: MailboxEmailAssignmentStatusEnum.fromJson(json[r'status']),
        hostname: mapValueOfType<String>(json, r'hostname'),
        error: MailboxEmailAssignmentError.fromJson(json[r'error']),
      );
    }
    return null;
  }

  static List<MailboxEmailAssignment> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailAssignment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailAssignment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailAssignment> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailAssignment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailAssignment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailAssignment-objects as value to a dart map
  static Map<String, List<MailboxEmailAssignment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailAssignment>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailAssignment.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum MailboxEmailAssignmentStatusEnum {
  pending._(r'pending'),
  active._(r'active'),
  failed._(r'failed'),
  ;

  /// Instantiate a new enum with the provided value.
  const MailboxEmailAssignmentStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [MailboxEmailAssignmentStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static MailboxEmailAssignmentStatusEnum? fromJson(dynamic value) => MailboxEmailAssignmentStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [MailboxEmailAssignmentStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<MailboxEmailAssignmentStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailAssignmentStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailAssignmentStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MailboxEmailAssignmentStatusEnum] to String,
/// and [decode] dynamic data back to [MailboxEmailAssignmentStatusEnum].
class MailboxEmailAssignmentStatusEnumTypeTransformer {
  factory MailboxEmailAssignmentStatusEnumTypeTransformer() => _instance ??= const MailboxEmailAssignmentStatusEnumTypeTransformer._();

  const MailboxEmailAssignmentStatusEnumTypeTransformer._();

  String encode(MailboxEmailAssignmentStatusEnum data) => data._value;

  /// Returns the instance of [MailboxEmailAssignmentStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MailboxEmailAssignmentStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is MailboxEmailAssignmentStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'pending': return MailboxEmailAssignmentStatusEnum.pending;
        case r'active': return MailboxEmailAssignmentStatusEnum.active;
        case r'failed': return MailboxEmailAssignmentStatusEnum.failed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static MailboxEmailAssignmentStatusEnumTypeTransformer? _instance;
}



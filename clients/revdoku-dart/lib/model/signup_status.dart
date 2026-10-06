//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SignupStatus {
  /// Returns a new [SignupStatus] instance.
  SignupStatus({
    required this.status,
    this.accountId,
    this.mailboxId,
  });

  SignupStatusStatusEnum status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? mailboxId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignupStatus &&
    other.status == status &&
    other.accountId == accountId &&
    other.mailboxId == mailboxId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (mailboxId == null ? 0 : mailboxId!.hashCode);

  @override
  String toString() => 'SignupStatus[status=$status, accountId=$accountId, mailboxId=$mailboxId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'status'] = this.status;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.mailboxId != null) {
      json[r'mailbox_id'] = this.mailboxId;
    }
    return json;
  }

  /// Returns a new [SignupStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'status'), 'Required key "SignupStatus[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "SignupStatus[status]" has a null value in JSON.');
        return true;
      }());

      return SignupStatus(
        status: SignupStatusStatusEnum.fromJson(json[r'status'])!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        mailboxId: mapValueOfType<String>(json, r'mailbox_id'),
      );
    }
    return null;
  }

  static List<SignupStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupStatus> mapFromJson(dynamic json) {
    final map = <String, SignupStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupStatus-objects as value to a dart map
  static Map<String, List<SignupStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignupStatus>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupStatus.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
  };
}


enum SignupStatusStatusEnum {
  completed._(r'completed'),
  ;

  /// Instantiate a new enum with the provided value.
  const SignupStatusStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SignupStatusStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SignupStatusStatusEnum? fromJson(dynamic value) => SignupStatusStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SignupStatusStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SignupStatusStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupStatusStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupStatusStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SignupStatusStatusEnum] to String,
/// and [decode] dynamic data back to [SignupStatusStatusEnum].
class SignupStatusStatusEnumTypeTransformer {
  factory SignupStatusStatusEnumTypeTransformer() => _instance ??= const SignupStatusStatusEnumTypeTransformer._();

  const SignupStatusStatusEnumTypeTransformer._();

  String encode(SignupStatusStatusEnum data) => data._value;

  /// Returns the instance of [SignupStatusStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SignupStatusStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SignupStatusStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'completed': return SignupStatusStatusEnum.completed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SignupStatusStatusEnumTypeTransformer? _instance;
}



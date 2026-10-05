//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class VerifyAgentSignup200ResponseDataSignup {
  /// Returns a new [VerifyAgentSignup200ResponseDataSignup] instance.
  VerifyAgentSignup200ResponseDataSignup({
    required this.status,
    required this.accountId,
    required this.mailboxId,
  });

  VerifyAgentSignup200ResponseDataSignupStatusEnum status;

  String accountId;

  String mailboxId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifyAgentSignup200ResponseDataSignup &&
    other.status == status &&
    other.accountId == accountId &&
    other.mailboxId == mailboxId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status.hashCode) +
    (accountId.hashCode) +
    (mailboxId.hashCode);

  @override
  String toString() => 'VerifyAgentSignup200ResponseDataSignup[status=$status, accountId=$accountId, mailboxId=$mailboxId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'status'] = this.status;
      json[r'account_id'] = this.accountId;
      json[r'mailbox_id'] = this.mailboxId;
    return json;
  }

  /// Returns a new [VerifyAgentSignup200ResponseDataSignup] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifyAgentSignup200ResponseDataSignup? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'status'), 'Required key "VerifyAgentSignup200ResponseDataSignup[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "VerifyAgentSignup200ResponseDataSignup[status]" has a null value in JSON.');
        assert(json.containsKey(r'account_id'), 'Required key "VerifyAgentSignup200ResponseDataSignup[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "VerifyAgentSignup200ResponseDataSignup[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'mailbox_id'), 'Required key "VerifyAgentSignup200ResponseDataSignup[mailbox_id]" is missing from JSON.');
        assert(json[r'mailbox_id'] != null, 'Required key "VerifyAgentSignup200ResponseDataSignup[mailbox_id]" has a null value in JSON.');
        return true;
      }());

      return VerifyAgentSignup200ResponseDataSignup(
        status: VerifyAgentSignup200ResponseDataSignupStatusEnum.fromJson(json[r'status'])!,
        accountId: mapValueOfType<String>(json, r'account_id')!,
        mailboxId: mapValueOfType<String>(json, r'mailbox_id')!,
      );
    }
    return null;
  }

  static List<VerifyAgentSignup200ResponseDataSignup> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAgentSignup200ResponseDataSignup>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAgentSignup200ResponseDataSignup.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifyAgentSignup200ResponseDataSignup> mapFromJson(dynamic json) {
    final map = <String, VerifyAgentSignup200ResponseDataSignup>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifyAgentSignup200ResponseDataSignup.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifyAgentSignup200ResponseDataSignup-objects as value to a dart map
  static Map<String, List<VerifyAgentSignup200ResponseDataSignup>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifyAgentSignup200ResponseDataSignup>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifyAgentSignup200ResponseDataSignup.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
    'account_id',
    'mailbox_id',
  };
}


enum VerifyAgentSignup200ResponseDataSignupStatusEnum {
  completed._(r'completed'),
  ;

  /// Instantiate a new enum with the provided value.
  const VerifyAgentSignup200ResponseDataSignupStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VerifyAgentSignup200ResponseDataSignupStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VerifyAgentSignup200ResponseDataSignupStatusEnum? fromJson(dynamic value) => VerifyAgentSignup200ResponseDataSignupStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VerifyAgentSignup200ResponseDataSignupStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VerifyAgentSignup200ResponseDataSignupStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAgentSignup200ResponseDataSignupStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAgentSignup200ResponseDataSignupStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerifyAgentSignup200ResponseDataSignupStatusEnum] to String,
/// and [decode] dynamic data back to [VerifyAgentSignup200ResponseDataSignupStatusEnum].
class VerifyAgentSignup200ResponseDataSignupStatusEnumTypeTransformer {
  factory VerifyAgentSignup200ResponseDataSignupStatusEnumTypeTransformer() => _instance ??= const VerifyAgentSignup200ResponseDataSignupStatusEnumTypeTransformer._();

  const VerifyAgentSignup200ResponseDataSignupStatusEnumTypeTransformer._();

  String encode(VerifyAgentSignup200ResponseDataSignupStatusEnum data) => data._value;

  /// Returns the instance of [VerifyAgentSignup200ResponseDataSignupStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerifyAgentSignup200ResponseDataSignupStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is VerifyAgentSignup200ResponseDataSignupStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'completed': return VerifyAgentSignup200ResponseDataSignupStatusEnum.completed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VerifyAgentSignup200ResponseDataSignupStatusEnumTypeTransformer? _instance;
}



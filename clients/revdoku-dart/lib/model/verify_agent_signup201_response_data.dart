//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class VerifyAgentSignup201ResponseData {
  /// Returns a new [VerifyAgentSignup201ResponseData] instance.
  VerifyAgentSignup201ResponseData({
    required this.signup,
    required this.apiKey,
    required this.scope,
    required this.expiresAt,
    required this.account,
    required this.mailbox,
  });

  VerifyAgentSignup201ResponseDataSignup signup;

  /// Returned once; store privately. Never write to logs or chat.
  String apiKey;

  VerifyAgentSignup201ResponseDataScopeEnum scope;

  DateTime expiresAt;

  VerifyAgentSignup201ResponseDataAccount account;

  VerifyAgentSignup201ResponseDataMailbox mailbox;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifyAgentSignup201ResponseData &&
    other.signup == signup &&
    other.apiKey == apiKey &&
    other.scope == scope &&
    other.expiresAt == expiresAt &&
    other.account == account &&
    other.mailbox == mailbox;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signup.hashCode) +
    (apiKey.hashCode) +
    (scope.hashCode) +
    (expiresAt.hashCode) +
    (account.hashCode) +
    (mailbox.hashCode);

  @override
  String toString() => 'VerifyAgentSignup201ResponseData[signup=$signup, apiKey=$apiKey, scope=$scope, expiresAt=$expiresAt, account=$account, mailbox=$mailbox]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'signup'] = this.signup;
      json[r'api_key'] = this.apiKey;
      json[r'scope'] = this.scope;
      json[r'expires_at'] = this.expiresAt.toUtc().toIso8601String();
      json[r'account'] = this.account;
      json[r'mailbox'] = this.mailbox;
    return json;
  }

  /// Returns a new [VerifyAgentSignup201ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifyAgentSignup201ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'signup'), 'Required key "VerifyAgentSignup201ResponseData[signup]" is missing from JSON.');
        assert(json[r'signup'] != null, 'Required key "VerifyAgentSignup201ResponseData[signup]" has a null value in JSON.');
        assert(json.containsKey(r'api_key'), 'Required key "VerifyAgentSignup201ResponseData[api_key]" is missing from JSON.');
        assert(json[r'api_key'] != null, 'Required key "VerifyAgentSignup201ResponseData[api_key]" has a null value in JSON.');
        assert(json.containsKey(r'scope'), 'Required key "VerifyAgentSignup201ResponseData[scope]" is missing from JSON.');
        assert(json[r'scope'] != null, 'Required key "VerifyAgentSignup201ResponseData[scope]" has a null value in JSON.');
        assert(json.containsKey(r'expires_at'), 'Required key "VerifyAgentSignup201ResponseData[expires_at]" is missing from JSON.');
        assert(json[r'expires_at'] != null, 'Required key "VerifyAgentSignup201ResponseData[expires_at]" has a null value in JSON.');
        assert(json.containsKey(r'account'), 'Required key "VerifyAgentSignup201ResponseData[account]" is missing from JSON.');
        assert(json[r'account'] != null, 'Required key "VerifyAgentSignup201ResponseData[account]" has a null value in JSON.');
        assert(json.containsKey(r'mailbox'), 'Required key "VerifyAgentSignup201ResponseData[mailbox]" is missing from JSON.');
        assert(json[r'mailbox'] != null, 'Required key "VerifyAgentSignup201ResponseData[mailbox]" has a null value in JSON.');
        return true;
      }());

      return VerifyAgentSignup201ResponseData(
        signup: VerifyAgentSignup201ResponseDataSignup.fromJson(json[r'signup'])!,
        apiKey: mapValueOfType<String>(json, r'api_key')!,
        scope: VerifyAgentSignup201ResponseDataScopeEnum.fromJson(json[r'scope'])!,
        expiresAt: mapDateTime(json, r'expires_at', r'')!,
        account: VerifyAgentSignup201ResponseDataAccount.fromJson(json[r'account'])!,
        mailbox: VerifyAgentSignup201ResponseDataMailbox.fromJson(json[r'mailbox'])!,
      );
    }
    return null;
  }

  static List<VerifyAgentSignup201ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAgentSignup201ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAgentSignup201ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifyAgentSignup201ResponseData> mapFromJson(dynamic json) {
    final map = <String, VerifyAgentSignup201ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifyAgentSignup201ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifyAgentSignup201ResponseData-objects as value to a dart map
  static Map<String, List<VerifyAgentSignup201ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifyAgentSignup201ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifyAgentSignup201ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'signup',
    'api_key',
    'scope',
    'expires_at',
    'account',
    'mailbox',
  };
}


enum VerifyAgentSignup201ResponseDataScopeEnum {
  mailboxRead._(r'mailbox_read'),
  mailboxWrite._(r'mailbox_write'),
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const VerifyAgentSignup201ResponseDataScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VerifyAgentSignup201ResponseDataScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VerifyAgentSignup201ResponseDataScopeEnum? fromJson(dynamic value) => VerifyAgentSignup201ResponseDataScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VerifyAgentSignup201ResponseDataScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VerifyAgentSignup201ResponseDataScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAgentSignup201ResponseDataScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAgentSignup201ResponseDataScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerifyAgentSignup201ResponseDataScopeEnum] to String,
/// and [decode] dynamic data back to [VerifyAgentSignup201ResponseDataScopeEnum].
class VerifyAgentSignup201ResponseDataScopeEnumTypeTransformer {
  factory VerifyAgentSignup201ResponseDataScopeEnumTypeTransformer() => _instance ??= const VerifyAgentSignup201ResponseDataScopeEnumTypeTransformer._();

  const VerifyAgentSignup201ResponseDataScopeEnumTypeTransformer._();

  String encode(VerifyAgentSignup201ResponseDataScopeEnum data) => data._value;

  /// Returns the instance of [VerifyAgentSignup201ResponseDataScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerifyAgentSignup201ResponseDataScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is VerifyAgentSignup201ResponseDataScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_read': return VerifyAgentSignup201ResponseDataScopeEnum.mailboxRead;
        case r'mailbox_write': return VerifyAgentSignup201ResponseDataScopeEnum.mailboxWrite;
        case r'mailbox_admin': return VerifyAgentSignup201ResponseDataScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VerifyAgentSignup201ResponseDataScopeEnumTypeTransformer? _instance;
}



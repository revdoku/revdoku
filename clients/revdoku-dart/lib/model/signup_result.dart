//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SignupResult {
  /// Returns a new [SignupResult] instance.
  SignupResult({
    required this.signup,
    this.apiKey,
    this.scope,
    this.expiresAt,
    this.account,
    this.mailbox,
    this.recoveryUrl,
  });

  SignupStatus signup;

  /// Returned once; store privately. Never write to logs or chat.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? apiKey;

  SignupResultScopeEnum? scope;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? expiresAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SignupAccount? account;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SignupMailbox? mailbox;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? recoveryUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignupResult &&
    other.signup == signup &&
    other.apiKey == apiKey &&
    other.scope == scope &&
    other.expiresAt == expiresAt &&
    other.account == account &&
    other.mailbox == mailbox &&
    other.recoveryUrl == recoveryUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signup.hashCode) +
    (apiKey == null ? 0 : apiKey!.hashCode) +
    (scope == null ? 0 : scope!.hashCode) +
    (expiresAt == null ? 0 : expiresAt!.hashCode) +
    (account == null ? 0 : account!.hashCode) +
    (mailbox == null ? 0 : mailbox!.hashCode) +
    (recoveryUrl == null ? 0 : recoveryUrl!.hashCode);

  @override
  String toString() => 'SignupResult[signup=$signup, apiKey=$apiKey, scope=$scope, expiresAt=$expiresAt, account=$account, mailbox=$mailbox, recoveryUrl=$recoveryUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'signup'] = this.signup;
    if (this.apiKey != null) {
      json[r'api_key'] = this.apiKey;
    }
    if (this.scope != null) {
      json[r'scope'] = this.scope;
    }
    if (this.expiresAt != null) {
      json[r'expires_at'] = this.expiresAt!.toUtc().toIso8601String();
    }
    if (this.account != null) {
      json[r'account'] = this.account;
    }
    if (this.mailbox != null) {
      json[r'mailbox'] = this.mailbox;
    }
    if (this.recoveryUrl != null) {
      json[r'recovery_url'] = this.recoveryUrl;
    }
    return json;
  }

  /// Returns a new [SignupResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'signup'), 'Required key "SignupResult[signup]" is missing from JSON.');
        assert(json[r'signup'] != null, 'Required key "SignupResult[signup]" has a null value in JSON.');
        return true;
      }());

      return SignupResult(
        signup: SignupStatus.fromJson(json[r'signup'])!,
        apiKey: mapValueOfType<String>(json, r'api_key'),
        scope: SignupResultScopeEnum.fromJson(json[r'scope']),
        expiresAt: mapDateTime(json, r'expires_at', r''),
        account: SignupAccount.fromJson(json[r'account']),
        mailbox: SignupMailbox.fromJson(json[r'mailbox']),
        recoveryUrl: mapValueOfType<String>(json, r'recovery_url'),
      );
    }
    return null;
  }

  static List<SignupResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupResult> mapFromJson(dynamic json) {
    final map = <String, SignupResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupResult-objects as value to a dart map
  static Map<String, List<SignupResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignupResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'signup',
  };
}


enum SignupResultScopeEnum {
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const SignupResultScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SignupResultScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SignupResultScopeEnum? fromJson(dynamic value) => SignupResultScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SignupResultScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SignupResultScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupResultScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupResultScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SignupResultScopeEnum] to String,
/// and [decode] dynamic data back to [SignupResultScopeEnum].
class SignupResultScopeEnumTypeTransformer {
  factory SignupResultScopeEnumTypeTransformer() => _instance ??= const SignupResultScopeEnumTypeTransformer._();

  const SignupResultScopeEnumTypeTransformer._();

  String encode(SignupResultScopeEnum data) => data._value;

  /// Returns the instance of [SignupResultScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SignupResultScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SignupResultScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_admin': return SignupResultScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SignupResultScopeEnumTypeTransformer? _instance;
}



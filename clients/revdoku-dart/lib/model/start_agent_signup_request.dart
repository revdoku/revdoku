//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class StartAgentSignupRequest {
  /// Returns a new [StartAgentSignupRequest] instance.
  StartAgentSignupRequest({
    required this.humanOperatorEmail,
    this.username,
    this.label,
    this.permissionScope = StartAgentSignupRequestPermissionScopeEnum.mailboxAdmin,
    required this.acceptTermsAndPolicy,
  });

  /// Email supplied by the human who owns and authorizes this account. Do not use an AI agent mailbox or invent this value. Verification proves control of the address.
  String humanOperatorEmail;

  /// Optional exact name for the first mailbox. Omit to generate a name. Platform reserved and retired name rules apply.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? label;

  StartAgentSignupRequestPermissionScopeEnum permissionScope;

  /// The human agrees to the current Terms (https://revdoku.com/terms) and service acceptable use policy (https://revdoku.com/acceptable-use), and acknowledges the privacy notice (https://revdoku.com/privacy). This is not consent to optional processing.
  bool acceptTermsAndPolicy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StartAgentSignupRequest &&
    other.humanOperatorEmail == humanOperatorEmail &&
    other.username == username &&
    other.label == label &&
    other.permissionScope == permissionScope &&
    other.acceptTermsAndPolicy == acceptTermsAndPolicy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (humanOperatorEmail.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (label == null ? 0 : label!.hashCode) +
    (permissionScope.hashCode) +
    (acceptTermsAndPolicy.hashCode);

  @override
  String toString() => 'StartAgentSignupRequest[humanOperatorEmail=$humanOperatorEmail, username=$username, label=$label, permissionScope=$permissionScope, acceptTermsAndPolicy=$acceptTermsAndPolicy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'human_operator_email'] = this.humanOperatorEmail;
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.label != null) {
      json[r'label'] = this.label;
    } else {
      json[r'label'] = null;
    }
      json[r'permission_scope'] = this.permissionScope;
      json[r'accept_terms_and_policy'] = this.acceptTermsAndPolicy;
    return json;
  }

  /// Returns a new [StartAgentSignupRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StartAgentSignupRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'human_operator_email'), 'Required key "StartAgentSignupRequest[human_operator_email]" is missing from JSON.');
        assert(json[r'human_operator_email'] != null, 'Required key "StartAgentSignupRequest[human_operator_email]" has a null value in JSON.');
        assert(json.containsKey(r'accept_terms_and_policy'), 'Required key "StartAgentSignupRequest[accept_terms_and_policy]" is missing from JSON.');
        assert(json[r'accept_terms_and_policy'] != null, 'Required key "StartAgentSignupRequest[accept_terms_and_policy]" has a null value in JSON.');
        return true;
      }());

      return StartAgentSignupRequest(
        humanOperatorEmail: mapValueOfType<String>(json, r'human_operator_email')!,
        username: mapValueOfType<String>(json, r'username'),
        label: mapValueOfType<String>(json, r'label'),
        permissionScope: StartAgentSignupRequestPermissionScopeEnum.fromJson(json[r'permission_scope']) ?? StartAgentSignupRequestPermissionScopeEnum.mailboxAdmin,
        acceptTermsAndPolicy: mapValueOfType<bool>(json, r'accept_terms_and_policy')!,
      );
    }
    return null;
  }

  static List<StartAgentSignupRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StartAgentSignupRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StartAgentSignupRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StartAgentSignupRequest> mapFromJson(dynamic json) {
    final map = <String, StartAgentSignupRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StartAgentSignupRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StartAgentSignupRequest-objects as value to a dart map
  static Map<String, List<StartAgentSignupRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StartAgentSignupRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StartAgentSignupRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'human_operator_email',
    'accept_terms_and_policy',
  };
}


enum StartAgentSignupRequestPermissionScopeEnum {
  mailboxRead._(r'mailbox_read'),
  mailboxWrite._(r'mailbox_write'),
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const StartAgentSignupRequestPermissionScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [StartAgentSignupRequestPermissionScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static StartAgentSignupRequestPermissionScopeEnum? fromJson(dynamic value) => StartAgentSignupRequestPermissionScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [StartAgentSignupRequestPermissionScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<StartAgentSignupRequestPermissionScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StartAgentSignupRequestPermissionScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StartAgentSignupRequestPermissionScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StartAgentSignupRequestPermissionScopeEnum] to String,
/// and [decode] dynamic data back to [StartAgentSignupRequestPermissionScopeEnum].
class StartAgentSignupRequestPermissionScopeEnumTypeTransformer {
  factory StartAgentSignupRequestPermissionScopeEnumTypeTransformer() => _instance ??= const StartAgentSignupRequestPermissionScopeEnumTypeTransformer._();

  const StartAgentSignupRequestPermissionScopeEnumTypeTransformer._();

  String encode(StartAgentSignupRequestPermissionScopeEnum data) => data._value;

  /// Returns the instance of [StartAgentSignupRequestPermissionScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StartAgentSignupRequestPermissionScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is StartAgentSignupRequestPermissionScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_read': return StartAgentSignupRequestPermissionScopeEnum.mailboxRead;
        case r'mailbox_write': return StartAgentSignupRequestPermissionScopeEnum.mailboxWrite;
        case r'mailbox_admin': return StartAgentSignupRequestPermissionScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static StartAgentSignupRequestPermissionScopeEnumTypeTransformer? _instance;
}



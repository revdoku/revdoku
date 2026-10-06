//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class VerifyAgentSignupRequest {
  /// Returns a new [VerifyAgentSignupRequest] instance.
  VerifyAgentSignupRequest({
    required this.code,
    required this.signupToken,
  });

  /// Six-digit email verification code.
  String code;

  /// Private signup token returned by the first request. Send only in the JSON body; never log it or show it in chat.
  String signupToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifyAgentSignupRequest &&
    other.code == code &&
    other.signupToken == signupToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code.hashCode) +
    (signupToken.hashCode);

  @override
  String toString() => 'VerifyAgentSignupRequest[code=$code, signupToken=$signupToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = this.code;
      json[r'signup_token'] = this.signupToken;
    return json;
  }

  /// Returns a new [VerifyAgentSignupRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifyAgentSignupRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'code'), 'Required key "VerifyAgentSignupRequest[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "VerifyAgentSignupRequest[code]" has a null value in JSON.');
        assert(json.containsKey(r'signup_token'), 'Required key "VerifyAgentSignupRequest[signup_token]" is missing from JSON.');
        assert(json[r'signup_token'] != null, 'Required key "VerifyAgentSignupRequest[signup_token]" has a null value in JSON.');
        return true;
      }());

      return VerifyAgentSignupRequest(
        code: mapValueOfType<String>(json, r'code')!,
        signupToken: mapValueOfType<String>(json, r'signup_token')!,
      );
    }
    return null;
  }

  static List<VerifyAgentSignupRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAgentSignupRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAgentSignupRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifyAgentSignupRequest> mapFromJson(dynamic json) {
    final map = <String, VerifyAgentSignupRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifyAgentSignupRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifyAgentSignupRequest-objects as value to a dart map
  static Map<String, List<VerifyAgentSignupRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifyAgentSignupRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifyAgentSignupRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'code',
    'signup_token',
  };
}


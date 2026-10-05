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
    this.code,
    this.username,
    required this.signupToken,
  });

  /// Required until the challenge is verified; collect privately, never in chat.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? code;

  /// Optional exact name for the first mailbox. Omit to generate a name. Platform reserved and retired name rules apply.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  /// Private signup token returned by the first request. Send only in the JSON body; never log it or show it in chat.
  String signupToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifyAgentSignupRequest &&
    other.code == code &&
    other.username == username &&
    other.signupToken == signupToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code == null ? 0 : code!.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (signupToken.hashCode);

  @override
  String toString() => 'VerifyAgentSignupRequest[code=$code, username=$username, signupToken=$signupToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.code != null) {
      json[r'code'] = this.code;
    }
    if (this.username != null) {
      json[r'username'] = this.username;
    }
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
        assert(json.containsKey(r'signup_token'), 'Required key "VerifyAgentSignupRequest[signup_token]" is missing from JSON.');
        assert(json[r'signup_token'] != null, 'Required key "VerifyAgentSignupRequest[signup_token]" has a null value in JSON.');
        return true;
      }());

      return VerifyAgentSignupRequest(
        code: mapValueOfType<String>(json, r'code'),
        username: mapValueOfType<String>(json, r'username'),
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
    'signup_token',
  };
}


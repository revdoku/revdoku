//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ResendAgentSignupCodeRequest {
  /// Returns a new [ResendAgentSignupCodeRequest] instance.
  ResendAgentSignupCodeRequest({
    required this.signupToken,
  });

  /// Private signup token returned by the first request. Send only in the JSON body; never log it or show it in chat.
  String signupToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResendAgentSignupCodeRequest &&
    other.signupToken == signupToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signupToken.hashCode);

  @override
  String toString() => 'ResendAgentSignupCodeRequest[signupToken=$signupToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'signup_token'] = this.signupToken;
    return json;
  }

  /// Returns a new [ResendAgentSignupCodeRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResendAgentSignupCodeRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'signup_token'), 'Required key "ResendAgentSignupCodeRequest[signup_token]" is missing from JSON.');
        assert(json[r'signup_token'] != null, 'Required key "ResendAgentSignupCodeRequest[signup_token]" has a null value in JSON.');
        return true;
      }());

      return ResendAgentSignupCodeRequest(
        signupToken: mapValueOfType<String>(json, r'signup_token')!,
      );
    }
    return null;
  }

  static List<ResendAgentSignupCodeRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResendAgentSignupCodeRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResendAgentSignupCodeRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResendAgentSignupCodeRequest> mapFromJson(dynamic json) {
    final map = <String, ResendAgentSignupCodeRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResendAgentSignupCodeRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResendAgentSignupCodeRequest-objects as value to a dart map
  static Map<String, List<ResendAgentSignupCodeRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResendAgentSignupCodeRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResendAgentSignupCodeRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'signup_token',
  };
}


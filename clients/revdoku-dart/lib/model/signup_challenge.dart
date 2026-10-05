//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SignupChallenge {
  /// Returns a new [SignupChallenge] instance.
  SignupChallenge({
    required this.expiresIn,
    required this.resendAfter,
    required this.signupToken,
  });

  /// Minimum value: 0
  int expiresIn;

  /// Minimum value: 0
  int resendAfter;

  /// Private signup token returned by the first request. Send only in the JSON body; never log it or show it in chat.
  String signupToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignupChallenge &&
    other.expiresIn == expiresIn &&
    other.resendAfter == resendAfter &&
    other.signupToken == signupToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expiresIn.hashCode) +
    (resendAfter.hashCode) +
    (signupToken.hashCode);

  @override
  String toString() => 'SignupChallenge[expiresIn=$expiresIn, resendAfter=$resendAfter, signupToken=$signupToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expires_in'] = this.expiresIn;
      json[r'resend_after'] = this.resendAfter;
      json[r'signup_token'] = this.signupToken;
    return json;
  }

  /// Returns a new [SignupChallenge] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupChallenge? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expires_in'), 'Required key "SignupChallenge[expires_in]" is missing from JSON.');
        assert(json[r'expires_in'] != null, 'Required key "SignupChallenge[expires_in]" has a null value in JSON.');
        assert(json.containsKey(r'resend_after'), 'Required key "SignupChallenge[resend_after]" is missing from JSON.');
        assert(json[r'resend_after'] != null, 'Required key "SignupChallenge[resend_after]" has a null value in JSON.');
        assert(json.containsKey(r'signup_token'), 'Required key "SignupChallenge[signup_token]" is missing from JSON.');
        assert(json[r'signup_token'] != null, 'Required key "SignupChallenge[signup_token]" has a null value in JSON.');
        return true;
      }());

      return SignupChallenge(
        expiresIn: mapValueOfType<int>(json, r'expires_in')!,
        resendAfter: mapValueOfType<int>(json, r'resend_after')!,
        signupToken: mapValueOfType<String>(json, r'signup_token')!,
      );
    }
    return null;
  }

  static List<SignupChallenge> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupChallenge>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupChallenge.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupChallenge> mapFromJson(dynamic json) {
    final map = <String, SignupChallenge>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupChallenge.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupChallenge-objects as value to a dart map
  static Map<String, List<SignupChallenge>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignupChallenge>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupChallenge.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expires_in',
    'resend_after',
    'signup_token',
  };
}


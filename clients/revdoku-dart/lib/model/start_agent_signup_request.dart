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
    required this.email,
    required this.acceptTermsAndPolicy,
  });

  /// Email address for the new account.
  String email;

  /// Agree to the Terms (https://revdoku.com/terms) and Acceptable Use Policy (https://revdoku.com/acceptable-use), and acknowledge the Privacy Policy (https://revdoku.com/privacy).
  bool acceptTermsAndPolicy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StartAgentSignupRequest &&
    other.email == email &&
    other.acceptTermsAndPolicy == acceptTermsAndPolicy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (acceptTermsAndPolicy.hashCode);

  @override
  String toString() => 'StartAgentSignupRequest[email=$email, acceptTermsAndPolicy=$acceptTermsAndPolicy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
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
        assert(json.containsKey(r'email'), 'Required key "StartAgentSignupRequest[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "StartAgentSignupRequest[email]" has a null value in JSON.');
        assert(json.containsKey(r'accept_terms_and_policy'), 'Required key "StartAgentSignupRequest[accept_terms_and_policy]" is missing from JSON.');
        assert(json[r'accept_terms_and_policy'] != null, 'Required key "StartAgentSignupRequest[accept_terms_and_policy]" has a null value in JSON.');
        return true;
      }());

      return StartAgentSignupRequest(
        email: mapValueOfType<String>(json, r'email')!,
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
    'email',
    'accept_terms_and_policy',
  };
}


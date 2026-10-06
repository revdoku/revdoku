//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SignupPoliciesResponseDataPolicies {
  /// Returns a new [SignupPoliciesResponseDataPolicies] instance.
  SignupPoliciesResponseDataPolicies({
    required this.terms,
    required this.acceptableUse,
    required this.privacy,
  });

  SignupPolicyDocument terms;

  SignupPolicyDocument acceptableUse;

  SignupPolicyDocument privacy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignupPoliciesResponseDataPolicies &&
    other.terms == terms &&
    other.acceptableUse == acceptableUse &&
    other.privacy == privacy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (terms.hashCode) +
    (acceptableUse.hashCode) +
    (privacy.hashCode);

  @override
  String toString() => 'SignupPoliciesResponseDataPolicies[terms=$terms, acceptableUse=$acceptableUse, privacy=$privacy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'terms'] = this.terms;
      json[r'acceptable_use'] = this.acceptableUse;
      json[r'privacy'] = this.privacy;
    return json;
  }

  /// Returns a new [SignupPoliciesResponseDataPolicies] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupPoliciesResponseDataPolicies? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'terms'), 'Required key "SignupPoliciesResponseDataPolicies[terms]" is missing from JSON.');
        assert(json[r'terms'] != null, 'Required key "SignupPoliciesResponseDataPolicies[terms]" has a null value in JSON.');
        assert(json.containsKey(r'acceptable_use'), 'Required key "SignupPoliciesResponseDataPolicies[acceptable_use]" is missing from JSON.');
        assert(json[r'acceptable_use'] != null, 'Required key "SignupPoliciesResponseDataPolicies[acceptable_use]" has a null value in JSON.');
        assert(json.containsKey(r'privacy'), 'Required key "SignupPoliciesResponseDataPolicies[privacy]" is missing from JSON.');
        assert(json[r'privacy'] != null, 'Required key "SignupPoliciesResponseDataPolicies[privacy]" has a null value in JSON.');
        return true;
      }());

      return SignupPoliciesResponseDataPolicies(
        terms: SignupPolicyDocument.fromJson(json[r'terms'])!,
        acceptableUse: SignupPolicyDocument.fromJson(json[r'acceptable_use'])!,
        privacy: SignupPolicyDocument.fromJson(json[r'privacy'])!,
      );
    }
    return null;
  }

  static List<SignupPoliciesResponseDataPolicies> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupPoliciesResponseDataPolicies>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupPoliciesResponseDataPolicies.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupPoliciesResponseDataPolicies> mapFromJson(dynamic json) {
    final map = <String, SignupPoliciesResponseDataPolicies>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupPoliciesResponseDataPolicies.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupPoliciesResponseDataPolicies-objects as value to a dart map
  static Map<String, List<SignupPoliciesResponseDataPolicies>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignupPoliciesResponseDataPolicies>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupPoliciesResponseDataPolicies.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'terms',
    'acceptable_use',
    'privacy',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SignupPoliciesResponseData {
  /// Returns a new [SignupPoliciesResponseData] instance.
  SignupPoliciesResponseData({
    required this.policies,
  });

  SignupPoliciesResponseDataPolicies policies;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignupPoliciesResponseData &&
    other.policies == policies;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (policies.hashCode);

  @override
  String toString() => 'SignupPoliciesResponseData[policies=$policies]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'policies'] = this.policies;
    return json;
  }

  /// Returns a new [SignupPoliciesResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupPoliciesResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'policies'), 'Required key "SignupPoliciesResponseData[policies]" is missing from JSON.');
        assert(json[r'policies'] != null, 'Required key "SignupPoliciesResponseData[policies]" has a null value in JSON.');
        return true;
      }());

      return SignupPoliciesResponseData(
        policies: SignupPoliciesResponseDataPolicies.fromJson(json[r'policies'])!,
      );
    }
    return null;
  }

  static List<SignupPoliciesResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupPoliciesResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupPoliciesResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupPoliciesResponseData> mapFromJson(dynamic json) {
    final map = <String, SignupPoliciesResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupPoliciesResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupPoliciesResponseData-objects as value to a dart map
  static Map<String, List<SignupPoliciesResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignupPoliciesResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupPoliciesResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'policies',
  };
}


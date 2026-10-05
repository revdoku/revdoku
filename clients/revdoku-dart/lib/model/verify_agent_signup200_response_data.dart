//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class VerifyAgentSignup200ResponseData {
  /// Returns a new [VerifyAgentSignup200ResponseData] instance.
  VerifyAgentSignup200ResponseData({
    required this.signup,
    required this.recoveryUrl,
  });

  VerifyAgentSignup200ResponseDataSignup signup;

  String recoveryUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifyAgentSignup200ResponseData &&
    other.signup == signup &&
    other.recoveryUrl == recoveryUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signup.hashCode) +
    (recoveryUrl.hashCode);

  @override
  String toString() => 'VerifyAgentSignup200ResponseData[signup=$signup, recoveryUrl=$recoveryUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'signup'] = this.signup;
      json[r'recovery_url'] = this.recoveryUrl;
    return json;
  }

  /// Returns a new [VerifyAgentSignup200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifyAgentSignup200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'signup'), 'Required key "VerifyAgentSignup200ResponseData[signup]" is missing from JSON.');
        assert(json[r'signup'] != null, 'Required key "VerifyAgentSignup200ResponseData[signup]" has a null value in JSON.');
        assert(json.containsKey(r'recovery_url'), 'Required key "VerifyAgentSignup200ResponseData[recovery_url]" is missing from JSON.');
        assert(json[r'recovery_url'] != null, 'Required key "VerifyAgentSignup200ResponseData[recovery_url]" has a null value in JSON.');
        return true;
      }());

      return VerifyAgentSignup200ResponseData(
        signup: VerifyAgentSignup200ResponseDataSignup.fromJson(json[r'signup'])!,
        recoveryUrl: mapValueOfType<String>(json, r'recovery_url')!,
      );
    }
    return null;
  }

  static List<VerifyAgentSignup200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAgentSignup200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAgentSignup200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifyAgentSignup200ResponseData> mapFromJson(dynamic json) {
    final map = <String, VerifyAgentSignup200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifyAgentSignup200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifyAgentSignup200ResponseData-objects as value to a dart map
  static Map<String, List<VerifyAgentSignup200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifyAgentSignup200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifyAgentSignup200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'signup',
    'recovery_url',
  };
}


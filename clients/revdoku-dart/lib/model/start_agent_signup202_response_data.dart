//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class StartAgentSignup202ResponseData {
  /// Returns a new [StartAgentSignup202ResponseData] instance.
  StartAgentSignup202ResponseData({
    required this.signup,
  });

  SignupChallenge signup;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StartAgentSignup202ResponseData &&
    other.signup == signup;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signup.hashCode);

  @override
  String toString() => 'StartAgentSignup202ResponseData[signup=$signup]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'signup'] = this.signup;
    return json;
  }

  /// Returns a new [StartAgentSignup202ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StartAgentSignup202ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'signup'), 'Required key "StartAgentSignup202ResponseData[signup]" is missing from JSON.');
        assert(json[r'signup'] != null, 'Required key "StartAgentSignup202ResponseData[signup]" has a null value in JSON.');
        return true;
      }());

      return StartAgentSignup202ResponseData(
        signup: SignupChallenge.fromJson(json[r'signup'])!,
      );
    }
    return null;
  }

  static List<StartAgentSignup202ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StartAgentSignup202ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StartAgentSignup202ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StartAgentSignup202ResponseData> mapFromJson(dynamic json) {
    final map = <String, StartAgentSignup202ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StartAgentSignup202ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StartAgentSignup202ResponseData-objects as value to a dart map
  static Map<String, List<StartAgentSignup202ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StartAgentSignup202ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StartAgentSignup202ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'signup',
  };
}


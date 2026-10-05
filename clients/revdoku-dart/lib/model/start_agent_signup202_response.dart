//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class StartAgentSignup202Response {
  /// Returns a new [StartAgentSignup202Response] instance.
  StartAgentSignup202Response({
    required this.success,
    required this.data,
  });

  bool success;

  StartAgentSignup202ResponseData data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StartAgentSignup202Response &&
    other.success == success &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'StartAgentSignup202Response[success=$success, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [StartAgentSignup202Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StartAgentSignup202Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'success'), 'Required key "StartAgentSignup202Response[success]" is missing from JSON.');
        assert(json[r'success'] != null, 'Required key "StartAgentSignup202Response[success]" has a null value in JSON.');
        assert(json.containsKey(r'data'), 'Required key "StartAgentSignup202Response[data]" is missing from JSON.');
        assert(json[r'data'] != null, 'Required key "StartAgentSignup202Response[data]" has a null value in JSON.');
        return true;
      }());

      return StartAgentSignup202Response(
        success: mapValueOfType<bool>(json, r'success')!,
        data: StartAgentSignup202ResponseData.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<StartAgentSignup202Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StartAgentSignup202Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StartAgentSignup202Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StartAgentSignup202Response> mapFromJson(dynamic json) {
    final map = <String, StartAgentSignup202Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StartAgentSignup202Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StartAgentSignup202Response-objects as value to a dart map
  static Map<String, List<StartAgentSignup202Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StartAgentSignup202Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StartAgentSignup202Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
    'data',
  };
}


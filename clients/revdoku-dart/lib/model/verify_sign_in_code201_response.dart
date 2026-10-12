//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class VerifySignInCode201Response {
  /// Returns a new [VerifySignInCode201Response] instance.
  VerifySignInCode201Response({
    required this.success,
    required this.data,
  });

  bool success;

  AgentConnection data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifySignInCode201Response &&
    other.success == success &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'VerifySignInCode201Response[success=$success, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [VerifySignInCode201Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifySignInCode201Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'success'), 'Required key "VerifySignInCode201Response[success]" is missing from JSON.');
        assert(json[r'success'] != null, 'Required key "VerifySignInCode201Response[success]" has a null value in JSON.');
        assert(json.containsKey(r'data'), 'Required key "VerifySignInCode201Response[data]" is missing from JSON.');
        assert(json[r'data'] != null, 'Required key "VerifySignInCode201Response[data]" has a null value in JSON.');
        return true;
      }());

      return VerifySignInCode201Response(
        success: mapValueOfType<bool>(json, r'success')!,
        data: AgentConnection.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<VerifySignInCode201Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifySignInCode201Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifySignInCode201Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifySignInCode201Response> mapFromJson(dynamic json) {
    final map = <String, VerifySignInCode201Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifySignInCode201Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifySignInCode201Response-objects as value to a dart map
  static Map<String, List<VerifySignInCode201Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifySignInCode201Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifySignInCode201Response.listFromJson(entry.value, growable: growable,);
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


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetEmailSubscription200Response {
  /// Returns a new [GetEmailSubscription200Response] instance.
  GetEmailSubscription200Response({
    required this.success,
    required this.data,
  });

  bool success;

  GetEmailSubscription200ResponseData data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetEmailSubscription200Response &&
    other.success == success &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'GetEmailSubscription200Response[success=$success, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [GetEmailSubscription200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetEmailSubscription200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'success'), 'Required key "GetEmailSubscription200Response[success]" is missing from JSON.');
        assert(json[r'success'] != null, 'Required key "GetEmailSubscription200Response[success]" has a null value in JSON.');
        assert(json.containsKey(r'data'), 'Required key "GetEmailSubscription200Response[data]" is missing from JSON.');
        assert(json[r'data'] != null, 'Required key "GetEmailSubscription200Response[data]" has a null value in JSON.');
        return true;
      }());

      return GetEmailSubscription200Response(
        success: mapValueOfType<bool>(json, r'success')!,
        data: GetEmailSubscription200ResponseData.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<GetEmailSubscription200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailSubscription200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailSubscription200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetEmailSubscription200Response> mapFromJson(dynamic json) {
    final map = <String, GetEmailSubscription200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetEmailSubscription200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetEmailSubscription200Response-objects as value to a dart map
  static Map<String, List<GetEmailSubscription200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetEmailSubscription200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetEmailSubscription200Response.listFromJson(entry.value, growable: growable,);
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


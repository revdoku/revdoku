//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetRevdokuStatus200ResponseDataFeatures {
  /// Returns a new [GetRevdokuStatus200ResponseDataFeatures] instance.
  GetRevdokuStatus200ResponseDataFeatures({
    this.emailDomains,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailDomains;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetRevdokuStatus200ResponseDataFeatures &&
    other.emailDomains == emailDomains;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (emailDomains == null ? 0 : emailDomains!.hashCode);

  @override
  String toString() => 'GetRevdokuStatus200ResponseDataFeatures[emailDomains=$emailDomains]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.emailDomains != null) {
      json[r'email_domains'] = this.emailDomains;
    }
    return json;
  }

  /// Returns a new [GetRevdokuStatus200ResponseDataFeatures] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetRevdokuStatus200ResponseDataFeatures? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return GetRevdokuStatus200ResponseDataFeatures(
        emailDomains: mapValueOfType<bool>(json, r'email_domains'),
      );
    }
    return null;
  }

  static List<GetRevdokuStatus200ResponseDataFeatures> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetRevdokuStatus200ResponseDataFeatures>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetRevdokuStatus200ResponseDataFeatures.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetRevdokuStatus200ResponseDataFeatures> mapFromJson(dynamic json) {
    final map = <String, GetRevdokuStatus200ResponseDataFeatures>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetRevdokuStatus200ResponseDataFeatures.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetRevdokuStatus200ResponseDataFeatures-objects as value to a dart map
  static Map<String, List<GetRevdokuStatus200ResponseDataFeatures>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetRevdokuStatus200ResponseDataFeatures>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetRevdokuStatus200ResponseDataFeatures.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


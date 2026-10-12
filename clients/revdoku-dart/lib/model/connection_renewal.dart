//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ConnectionRenewal {
  /// Returns a new [ConnectionRenewal] instance.
  ConnectionRenewal({
    this.recommended,
    this.nextAction,
    this.browserUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? recommended;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nextAction;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? browserUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConnectionRenewal &&
    other.recommended == recommended &&
    other.nextAction == nextAction &&
    other.browserUrl == browserUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (recommended == null ? 0 : recommended!.hashCode) +
    (nextAction == null ? 0 : nextAction!.hashCode) +
    (browserUrl == null ? 0 : browserUrl!.hashCode);

  @override
  String toString() => 'ConnectionRenewal[recommended=$recommended, nextAction=$nextAction, browserUrl=$browserUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.recommended != null) {
      json[r'recommended'] = this.recommended;
    }
    if (this.nextAction != null) {
      json[r'next_action'] = this.nextAction;
    }
    if (this.browserUrl != null) {
      json[r'browser_url'] = this.browserUrl;
    }
    return json;
  }

  /// Returns a new [ConnectionRenewal] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConnectionRenewal? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ConnectionRenewal(
        recommended: mapValueOfType<bool>(json, r'recommended'),
        nextAction: mapValueOfType<String>(json, r'next_action'),
        browserUrl: mapValueOfType<String>(json, r'browser_url'),
      );
    }
    return null;
  }

  static List<ConnectionRenewal> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConnectionRenewal>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConnectionRenewal.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConnectionRenewal> mapFromJson(dynamic json) {
    final map = <String, ConnectionRenewal>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConnectionRenewal.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConnectionRenewal-objects as value to a dart map
  static Map<String, List<ConnectionRenewal>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConnectionRenewal>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConnectionRenewal.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ConnectionPermissions {
  /// Returns a new [ConnectionPermissions] instance.
  ConnectionPermissions({
    this.read,
    this.write,
    this.admin,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? read;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? write;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? admin;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConnectionPermissions &&
    other.read == read &&
    other.write == write &&
    other.admin == admin;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (read == null ? 0 : read!.hashCode) +
    (write == null ? 0 : write!.hashCode) +
    (admin == null ? 0 : admin!.hashCode);

  @override
  String toString() => 'ConnectionPermissions[read=$read, write=$write, admin=$admin]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.read != null) {
      json[r'read'] = this.read;
    }
    if (this.write != null) {
      json[r'write'] = this.write;
    }
    if (this.admin != null) {
      json[r'admin'] = this.admin;
    }
    return json;
  }

  /// Returns a new [ConnectionPermissions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConnectionPermissions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ConnectionPermissions(
        read: mapValueOfType<bool>(json, r'read'),
        write: mapValueOfType<bool>(json, r'write'),
        admin: mapValueOfType<bool>(json, r'admin'),
      );
    }
    return null;
  }

  static List<ConnectionPermissions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConnectionPermissions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConnectionPermissions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConnectionPermissions> mapFromJson(dynamic json) {
    final map = <String, ConnectionPermissions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConnectionPermissions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConnectionPermissions-objects as value to a dart map
  static Map<String, List<ConnectionPermissions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConnectionPermissions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConnectionPermissions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class FileVersionReason {
  /// Returns a new [FileVersionReason] instance.
  FileVersionReason({
    this.versionId,
    this.reason,
    this.createdById,
    this.versionNumber,
    this.createdAt,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? versionId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? reason;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdById;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? versionNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileVersionReason &&
    other.versionId == versionId &&
    other.reason == reason &&
    other.createdById == createdById &&
    other.versionNumber == versionNumber &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (versionId == null ? 0 : versionId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (createdById == null ? 0 : createdById!.hashCode) +
    (versionNumber == null ? 0 : versionNumber!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'FileVersionReason[versionId=$versionId, reason=$reason, createdById=$createdById, versionNumber=$versionNumber, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.versionId != null) {
      json[r'version_id'] = this.versionId;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    }
    if (this.createdById != null) {
      json[r'created_by_id'] = this.createdById;
    }
    if (this.versionNumber != null) {
      json[r'version_number'] = this.versionNumber;
    }
    if (this.createdAt != null) {
      json[r'created_at'] = this.createdAt!.toUtc().toIso8601String();
    }
    return json;
  }

  /// Returns a new [FileVersionReason] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileVersionReason? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return FileVersionReason(
        versionId: mapValueOfType<String>(json, r'version_id'),
        reason: mapValueOfType<String>(json, r'reason'),
        createdById: mapValueOfType<String>(json, r'created_by_id'),
        versionNumber: mapValueOfType<int>(json, r'version_number'),
        createdAt: mapDateTime(json, r'created_at', r''),
      );
    }
    return null;
  }

  static List<FileVersionReason> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileVersionReason>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileVersionReason.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileVersionReason> mapFromJson(dynamic json) {
    final map = <String, FileVersionReason>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileVersionReason.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileVersionReason-objects as value to a dart map
  static Map<String, List<FileVersionReason>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileVersionReason>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileVersionReason.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


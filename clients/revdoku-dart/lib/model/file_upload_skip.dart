//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class FileUploadSkip {
  /// Returns a new [FileUploadSkip] instance.
  FileUploadSkip({
    this.path,
    this.name,
    this.reason,
    this.code,
    this.inputIndex,
    this.details = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? path;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

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
  String? code;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? inputIndex;

  Map<String, Object?> details;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileUploadSkip &&
    other.path == path &&
    other.name == name &&
    other.reason == reason &&
    other.code == code &&
    other.inputIndex == inputIndex &&
    _deepEquality.equals(other.details, details);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (path == null ? 0 : path!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (code == null ? 0 : code!.hashCode) +
    (inputIndex == null ? 0 : inputIndex!.hashCode) +
    (details.hashCode);

  @override
  String toString() => 'FileUploadSkip[path=$path, name=$name, reason=$reason, code=$code, inputIndex=$inputIndex, details=$details]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.path != null) {
      json[r'path'] = this.path;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    }
    if (this.code != null) {
      json[r'code'] = this.code;
    }
    if (this.inputIndex != null) {
      json[r'input_index'] = this.inputIndex;
    }
      json[r'details'] = this.details;
    return json;
  }

  /// Returns a new [FileUploadSkip] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileUploadSkip? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return FileUploadSkip(
        path: mapValueOfType<String>(json, r'path'),
        name: mapValueOfType<String>(json, r'name'),
        reason: mapValueOfType<String>(json, r'reason'),
        code: mapValueOfType<String>(json, r'code'),
        inputIndex: mapValueOfType<int>(json, r'input_index'),
        details: mapCastOfType<String, Object?>(json, r'details') ?? const {},
      );
    }
    return null;
  }

  static List<FileUploadSkip> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileUploadSkip>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileUploadSkip.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileUploadSkip> mapFromJson(dynamic json) {
    final map = <String, FileUploadSkip>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileUploadSkip.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileUploadSkip-objects as value to a dart map
  static Map<String, List<FileUploadSkip>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileUploadSkip>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileUploadSkip.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


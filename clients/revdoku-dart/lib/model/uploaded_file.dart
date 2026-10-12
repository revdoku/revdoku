//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UploadedFile {
  /// Returns a new [UploadedFile] instance.
  UploadedFile({
    this.inputIndex,
    required this.path,
    required this.file,
    required this.version,
    required this.created,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? inputIndex;

  String path;

  MailboxFile file;

  FileVersion version;

  /// False when the path received a new version.
  bool created;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadedFile &&
    other.inputIndex == inputIndex &&
    other.path == path &&
    other.file == file &&
    other.version == version &&
    other.created == created;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (inputIndex == null ? 0 : inputIndex!.hashCode) +
    (path.hashCode) +
    (file.hashCode) +
    (version.hashCode) +
    (created.hashCode);

  @override
  String toString() => 'UploadedFile[inputIndex=$inputIndex, path=$path, file=$file, version=$version, created=$created]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.inputIndex != null) {
      json[r'input_index'] = this.inputIndex;
    }
      json[r'path'] = this.path;
      json[r'file'] = this.file;
      json[r'version'] = this.version;
      json[r'created'] = this.created;
    return json;
  }

  /// Returns a new [UploadedFile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadedFile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'path'), 'Required key "UploadedFile[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "UploadedFile[path]" has a null value in JSON.');
        assert(json.containsKey(r'file'), 'Required key "UploadedFile[file]" is missing from JSON.');
        assert(json[r'file'] != null, 'Required key "UploadedFile[file]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "UploadedFile[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "UploadedFile[version]" has a null value in JSON.');
        assert(json.containsKey(r'created'), 'Required key "UploadedFile[created]" is missing from JSON.');
        assert(json[r'created'] != null, 'Required key "UploadedFile[created]" has a null value in JSON.');
        return true;
      }());

      return UploadedFile(
        inputIndex: mapValueOfType<int>(json, r'input_index'),
        path: mapValueOfType<String>(json, r'path')!,
        file: MailboxFile.fromJson(json[r'file'])!,
        version: FileVersion.fromJson(json[r'version'])!,
        created: mapValueOfType<bool>(json, r'created')!,
      );
    }
    return null;
  }

  static List<UploadedFile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadedFile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadedFile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadedFile> mapFromJson(dynamic json) {
    final map = <String, UploadedFile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadedFile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadedFile-objects as value to a dart map
  static Map<String, List<UploadedFile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadedFile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadedFile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'path',
    'file',
    'version',
    'created',
  };
}


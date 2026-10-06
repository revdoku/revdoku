//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SavedFile {
  /// Returns a new [SavedFile] instance.
  SavedFile({
    required this.file,
    required this.version,
    required this.created,
    this.skipped,
    this.duplicate,
  });

  MailboxFile file;

  FileVersion version;

  bool created;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileUploadSkip? skipped;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? duplicate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SavedFile &&
    other.file == file &&
    other.version == version &&
    other.created == created &&
    other.skipped == skipped &&
    other.duplicate == duplicate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (file.hashCode) +
    (version.hashCode) +
    (created.hashCode) +
    (skipped == null ? 0 : skipped!.hashCode) +
    (duplicate == null ? 0 : duplicate!.hashCode);

  @override
  String toString() => 'SavedFile[file=$file, version=$version, created=$created, skipped=$skipped, duplicate=$duplicate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'file'] = this.file;
      json[r'version'] = this.version;
      json[r'created'] = this.created;
    if (this.skipped != null) {
      json[r'skipped'] = this.skipped;
    }
    if (this.duplicate != null) {
      json[r'duplicate'] = this.duplicate;
    }
    return json;
  }

  /// Returns a new [SavedFile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SavedFile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'file'), 'Required key "SavedFile[file]" is missing from JSON.');
        assert(json[r'file'] != null, 'Required key "SavedFile[file]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "SavedFile[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "SavedFile[version]" has a null value in JSON.');
        assert(json.containsKey(r'created'), 'Required key "SavedFile[created]" is missing from JSON.');
        assert(json[r'created'] != null, 'Required key "SavedFile[created]" has a null value in JSON.');
        return true;
      }());

      return SavedFile(
        file: MailboxFile.fromJson(json[r'file'])!,
        version: FileVersion.fromJson(json[r'version'])!,
        created: mapValueOfType<bool>(json, r'created')!,
        skipped: FileUploadSkip.fromJson(json[r'skipped']),
        duplicate: mapValueOfType<bool>(json, r'duplicate'),
      );
    }
    return null;
  }

  static List<SavedFile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SavedFile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SavedFile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SavedFile> mapFromJson(dynamic json) {
    final map = <String, SavedFile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SavedFile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SavedFile-objects as value to a dart map
  static Map<String, List<SavedFile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SavedFile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SavedFile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'file',
    'version',
    'created',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class FileDownload {
  /// Returns a new [FileDownload] instance.
  FileDownload({
    required this.download,
    required this.version,
    this.previouslyRead,
  });

  Download download;

  FileVersion version;

  /// Read state before this request, when tracking succeeded.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? previouslyRead;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileDownload &&
    other.download == download &&
    other.version == version &&
    other.previouslyRead == previouslyRead;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (download.hashCode) +
    (version.hashCode) +
    (previouslyRead == null ? 0 : previouslyRead!.hashCode);

  @override
  String toString() => 'FileDownload[download=$download, version=$version, previouslyRead=$previouslyRead]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'download'] = this.download;
      json[r'version'] = this.version;
    if (this.previouslyRead != null) {
      json[r'previously_read'] = this.previouslyRead;
    }
    return json;
  }

  /// Returns a new [FileDownload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileDownload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'download'), 'Required key "FileDownload[download]" is missing from JSON.');
        assert(json[r'download'] != null, 'Required key "FileDownload[download]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "FileDownload[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "FileDownload[version]" has a null value in JSON.');
        return true;
      }());

      return FileDownload(
        download: Download.fromJson(json[r'download'])!,
        version: FileVersion.fromJson(json[r'version'])!,
        previouslyRead: mapValueOfType<bool>(json, r'previously_read'),
      );
    }
    return null;
  }

  static List<FileDownload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileDownload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileDownload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileDownload> mapFromJson(dynamic json) {
    final map = <String, FileDownload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileDownload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileDownload-objects as value to a dart map
  static Map<String, List<FileDownload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileDownload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileDownload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'download',
    'version',
  };
}


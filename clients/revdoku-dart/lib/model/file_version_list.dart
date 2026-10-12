//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class FileVersionList {
  /// Returns a new [FileVersionList] instance.
  FileVersionList({
    this.versions = const [],
    required this.pagination,
  });

  List<FileVersion> versions;

  Pagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileVersionList &&
    _deepEquality.equals(other.versions, versions) &&
    other.pagination == pagination;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (versions.hashCode) +
    (pagination.hashCode);

  @override
  String toString() => 'FileVersionList[versions=$versions, pagination=$pagination]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'versions'] = this.versions;
      json[r'pagination'] = this.pagination;
    return json;
  }

  /// Returns a new [FileVersionList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileVersionList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'versions'), 'Required key "FileVersionList[versions]" is missing from JSON.');
        assert(json[r'versions'] != null, 'Required key "FileVersionList[versions]" has a null value in JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "FileVersionList[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "FileVersionList[pagination]" has a null value in JSON.');
        return true;
      }());

      return FileVersionList(
        versions: FileVersion.listFromJson(json[r'versions']),
        pagination: Pagination.fromJson(json[r'pagination'])!,
      );
    }
    return null;
  }

  static List<FileVersionList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileVersionList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileVersionList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileVersionList> mapFromJson(dynamic json) {
    final map = <String, FileVersionList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileVersionList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileVersionList-objects as value to a dart map
  static Map<String, List<FileVersionList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileVersionList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileVersionList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'versions',
    'pagination',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class FileList {
  /// Returns a new [FileList] instance.
  FileList({
    this.files = const [],
    required this.pagination,
  });

  List<MailboxFile> files;

  Pagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FileList &&
    _deepEquality.equals(other.files, files) &&
    other.pagination == pagination;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (files.hashCode) +
    (pagination.hashCode);

  @override
  String toString() => 'FileList[files=$files, pagination=$pagination]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'files'] = this.files;
      json[r'pagination'] = this.pagination;
    return json;
  }

  /// Returns a new [FileList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'files'), 'Required key "FileList[files]" is missing from JSON.');
        assert(json[r'files'] != null, 'Required key "FileList[files]" has a null value in JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "FileList[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "FileList[pagination]" has a null value in JSON.');
        return true;
      }());

      return FileList(
        files: MailboxFile.listFromJson(json[r'files']),
        pagination: Pagination.fromJson(json[r'pagination'])!,
      );
    }
    return null;
  }

  static List<FileList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileList> mapFromJson(dynamic json) {
    final map = <String, FileList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileList-objects as value to a dart map
  static Map<String, List<FileList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FileList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'files',
    'pagination',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AppendTextResult {
  /// Returns a new [AppendTextResult] instance.
  AppendTextResult({
    required this.file,
    required this.version,
    required this.path,
    required this.appended,
    required this.appendedBytes,
    required this.newlineInserted,
  });

  MailboxFile file;

  FileVersion version;

  String path;

  bool appended;

  /// Minimum value: 0
  int appendedBytes;

  bool newlineInserted;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppendTextResult &&
    other.file == file &&
    other.version == version &&
    other.path == path &&
    other.appended == appended &&
    other.appendedBytes == appendedBytes &&
    other.newlineInserted == newlineInserted;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (file.hashCode) +
    (version.hashCode) +
    (path.hashCode) +
    (appended.hashCode) +
    (appendedBytes.hashCode) +
    (newlineInserted.hashCode);

  @override
  String toString() => 'AppendTextResult[file=$file, version=$version, path=$path, appended=$appended, appendedBytes=$appendedBytes, newlineInserted=$newlineInserted]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'file'] = this.file;
      json[r'version'] = this.version;
      json[r'path'] = this.path;
      json[r'appended'] = this.appended;
      json[r'appended_bytes'] = this.appendedBytes;
      json[r'newline_inserted'] = this.newlineInserted;
    return json;
  }

  /// Returns a new [AppendTextResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppendTextResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'file'), 'Required key "AppendTextResult[file]" is missing from JSON.');
        assert(json[r'file'] != null, 'Required key "AppendTextResult[file]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "AppendTextResult[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "AppendTextResult[version]" has a null value in JSON.');
        assert(json.containsKey(r'path'), 'Required key "AppendTextResult[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "AppendTextResult[path]" has a null value in JSON.');
        assert(json.containsKey(r'appended'), 'Required key "AppendTextResult[appended]" is missing from JSON.');
        assert(json[r'appended'] != null, 'Required key "AppendTextResult[appended]" has a null value in JSON.');
        assert(json.containsKey(r'appended_bytes'), 'Required key "AppendTextResult[appended_bytes]" is missing from JSON.');
        assert(json[r'appended_bytes'] != null, 'Required key "AppendTextResult[appended_bytes]" has a null value in JSON.');
        assert(json.containsKey(r'newline_inserted'), 'Required key "AppendTextResult[newline_inserted]" is missing from JSON.');
        assert(json[r'newline_inserted'] != null, 'Required key "AppendTextResult[newline_inserted]" has a null value in JSON.');
        return true;
      }());

      return AppendTextResult(
        file: MailboxFile.fromJson(json[r'file'])!,
        version: FileVersion.fromJson(json[r'version'])!,
        path: mapValueOfType<String>(json, r'path')!,
        appended: mapValueOfType<bool>(json, r'appended')!,
        appendedBytes: mapValueOfType<int>(json, r'appended_bytes')!,
        newlineInserted: mapValueOfType<bool>(json, r'newline_inserted')!,
      );
    }
    return null;
  }

  static List<AppendTextResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AppendTextResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppendTextResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppendTextResult> mapFromJson(dynamic json) {
    final map = <String, AppendTextResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppendTextResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppendTextResult-objects as value to a dart map
  static Map<String, List<AppendTextResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AppendTextResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppendTextResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'file',
    'version',
    'path',
    'appended',
    'appended_bytes',
    'newline_inserted',
  };
}


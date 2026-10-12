//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class RestoredFileVersion {
  /// Returns a new [RestoredFileVersion] instance.
  RestoredFileVersion({
    required this.file,
    required this.version,
    required this.restoredFrom,
  });

  MailboxFile file;

  FileVersion version;

  FileVersion restoredFrom;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RestoredFileVersion &&
    other.file == file &&
    other.version == version &&
    other.restoredFrom == restoredFrom;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (file.hashCode) +
    (version.hashCode) +
    (restoredFrom.hashCode);

  @override
  String toString() => 'RestoredFileVersion[file=$file, version=$version, restoredFrom=$restoredFrom]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'file'] = this.file;
      json[r'version'] = this.version;
      json[r'restored_from'] = this.restoredFrom;
    return json;
  }

  /// Returns a new [RestoredFileVersion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RestoredFileVersion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'file'), 'Required key "RestoredFileVersion[file]" is missing from JSON.');
        assert(json[r'file'] != null, 'Required key "RestoredFileVersion[file]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "RestoredFileVersion[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "RestoredFileVersion[version]" has a null value in JSON.');
        assert(json.containsKey(r'restored_from'), 'Required key "RestoredFileVersion[restored_from]" is missing from JSON.');
        assert(json[r'restored_from'] != null, 'Required key "RestoredFileVersion[restored_from]" has a null value in JSON.');
        return true;
      }());

      return RestoredFileVersion(
        file: MailboxFile.fromJson(json[r'file'])!,
        version: FileVersion.fromJson(json[r'version'])!,
        restoredFrom: FileVersion.fromJson(json[r'restored_from'])!,
      );
    }
    return null;
  }

  static List<RestoredFileVersion> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RestoredFileVersion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RestoredFileVersion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RestoredFileVersion> mapFromJson(dynamic json) {
    final map = <String, RestoredFileVersion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RestoredFileVersion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RestoredFileVersion-objects as value to a dart map
  static Map<String, List<RestoredFileVersion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RestoredFileVersion>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RestoredFileVersion.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'file',
    'version',
    'restored_from',
  };
}


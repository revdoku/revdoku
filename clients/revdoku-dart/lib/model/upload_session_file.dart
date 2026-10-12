//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UploadSessionFile {
  /// Returns a new [UploadSessionFile] instance.
  UploadSessionFile({
    required this.path,
    required this.byteSize,
    required this.contentType,
    required this.checksum,
    required this.sha256,
  });

  /// Destination path in the mailbox. Paths under _email/ return EMAIL_PATH_READ_ONLY.
  String path;

  /// Minimum value: 0
  int byteSize;

  String contentType;

  /// Base64-encoded MD5 of the bytes.
  String checksum;

  /// Hex SHA-256 of the bytes.
  String sha256;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadSessionFile &&
    other.path == path &&
    other.byteSize == byteSize &&
    other.contentType == contentType &&
    other.checksum == checksum &&
    other.sha256 == sha256;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (path.hashCode) +
    (byteSize.hashCode) +
    (contentType.hashCode) +
    (checksum.hashCode) +
    (sha256.hashCode);

  @override
  String toString() => 'UploadSessionFile[path=$path, byteSize=$byteSize, contentType=$contentType, checksum=$checksum, sha256=$sha256]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'path'] = this.path;
      json[r'byte_size'] = this.byteSize;
      json[r'content_type'] = this.contentType;
      json[r'checksum'] = this.checksum;
      json[r'sha256'] = this.sha256;
    return json;
  }

  /// Returns a new [UploadSessionFile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadSessionFile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'path'), 'Required key "UploadSessionFile[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "UploadSessionFile[path]" has a null value in JSON.');
        assert(json.containsKey(r'byte_size'), 'Required key "UploadSessionFile[byte_size]" is missing from JSON.');
        assert(json[r'byte_size'] != null, 'Required key "UploadSessionFile[byte_size]" has a null value in JSON.');
        assert(json.containsKey(r'content_type'), 'Required key "UploadSessionFile[content_type]" is missing from JSON.');
        assert(json[r'content_type'] != null, 'Required key "UploadSessionFile[content_type]" has a null value in JSON.');
        assert(json.containsKey(r'checksum'), 'Required key "UploadSessionFile[checksum]" is missing from JSON.');
        assert(json[r'checksum'] != null, 'Required key "UploadSessionFile[checksum]" has a null value in JSON.');
        assert(json.containsKey(r'sha256'), 'Required key "UploadSessionFile[sha256]" is missing from JSON.');
        assert(json[r'sha256'] != null, 'Required key "UploadSessionFile[sha256]" has a null value in JSON.');
        return true;
      }());

      return UploadSessionFile(
        path: mapValueOfType<String>(json, r'path')!,
        byteSize: mapValueOfType<int>(json, r'byte_size')!,
        contentType: mapValueOfType<String>(json, r'content_type')!,
        checksum: mapValueOfType<String>(json, r'checksum')!,
        sha256: mapValueOfType<String>(json, r'sha256')!,
      );
    }
    return null;
  }

  static List<UploadSessionFile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadSessionFile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadSessionFile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadSessionFile> mapFromJson(dynamic json) {
    final map = <String, UploadSessionFile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadSessionFile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadSessionFile-objects as value to a dart map
  static Map<String, List<UploadSessionFile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadSessionFile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadSessionFile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'path',
    'byte_size',
    'content_type',
    'checksum',
    'sha256',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UploadSessionUpload {
  /// Returns a new [UploadSessionUpload] instance.
  UploadSessionUpload({
    this.inputIndex,
    required this.path,
    this.name,
    this.signedBlobId,
    required this.upload,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? inputIndex;

  String path;

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
  String? signedBlobId;

  StorageUpload upload;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadSessionUpload &&
    other.inputIndex == inputIndex &&
    other.path == path &&
    other.name == name &&
    other.signedBlobId == signedBlobId &&
    other.upload == upload;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (inputIndex == null ? 0 : inputIndex!.hashCode) +
    (path.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (signedBlobId == null ? 0 : signedBlobId!.hashCode) +
    (upload.hashCode);

  @override
  String toString() => 'UploadSessionUpload[inputIndex=$inputIndex, path=$path, name=$name, signedBlobId=$signedBlobId, upload=$upload]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.inputIndex != null) {
      json[r'input_index'] = this.inputIndex;
    }
      json[r'path'] = this.path;
    if (this.name != null) {
      json[r'name'] = this.name;
    }
    if (this.signedBlobId != null) {
      json[r'signed_blob_id'] = this.signedBlobId;
    }
      json[r'upload'] = this.upload;
    return json;
  }

  /// Returns a new [UploadSessionUpload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadSessionUpload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'path'), 'Required key "UploadSessionUpload[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "UploadSessionUpload[path]" has a null value in JSON.');
        assert(json.containsKey(r'upload'), 'Required key "UploadSessionUpload[upload]" is missing from JSON.');
        assert(json[r'upload'] != null, 'Required key "UploadSessionUpload[upload]" has a null value in JSON.');
        return true;
      }());

      return UploadSessionUpload(
        inputIndex: mapValueOfType<int>(json, r'input_index'),
        path: mapValueOfType<String>(json, r'path')!,
        name: mapValueOfType<String>(json, r'name'),
        signedBlobId: mapValueOfType<String>(json, r'signed_blob_id'),
        upload: StorageUpload.fromJson(json[r'upload'])!,
      );
    }
    return null;
  }

  static List<UploadSessionUpload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadSessionUpload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadSessionUpload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadSessionUpload> mapFromJson(dynamic json) {
    final map = <String, UploadSessionUpload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadSessionUpload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadSessionUpload-objects as value to a dart map
  static Map<String, List<UploadSessionUpload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadSessionUpload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadSessionUpload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'path',
    'upload',
  };
}


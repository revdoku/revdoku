//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class PreparedFileUpload {
  /// Returns a new [PreparedFileUpload] instance.
  PreparedFileUpload({
    this.signedId,
    this.filename,
    this.byteSize,
    this.checksum,
    this.contentType,
    this.serviceName,
    this.directUpload,
    this.file,
    this.version,
    this.skipped,
    this.duplicate,
    this.reason,
    this.details = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? signedId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? filename;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? byteSize;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? checksum;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contentType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serviceName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  StorageUpload? directUpload;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxFile? file;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileVersion? version;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? skipped;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? duplicate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? reason;

  Map<String, Object?> details;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PreparedFileUpload &&
    other.signedId == signedId &&
    other.filename == filename &&
    other.byteSize == byteSize &&
    other.checksum == checksum &&
    other.contentType == contentType &&
    other.serviceName == serviceName &&
    other.directUpload == directUpload &&
    other.file == file &&
    other.version == version &&
    other.skipped == skipped &&
    other.duplicate == duplicate &&
    other.reason == reason &&
    _deepEquality.equals(other.details, details);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signedId == null ? 0 : signedId!.hashCode) +
    (filename == null ? 0 : filename!.hashCode) +
    (byteSize == null ? 0 : byteSize!.hashCode) +
    (checksum == null ? 0 : checksum!.hashCode) +
    (contentType == null ? 0 : contentType!.hashCode) +
    (serviceName == null ? 0 : serviceName!.hashCode) +
    (directUpload == null ? 0 : directUpload!.hashCode) +
    (file == null ? 0 : file!.hashCode) +
    (version == null ? 0 : version!.hashCode) +
    (skipped == null ? 0 : skipped!.hashCode) +
    (duplicate == null ? 0 : duplicate!.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (details.hashCode);

  @override
  String toString() => 'PreparedFileUpload[signedId=$signedId, filename=$filename, byteSize=$byteSize, checksum=$checksum, contentType=$contentType, serviceName=$serviceName, directUpload=$directUpload, file=$file, version=$version, skipped=$skipped, duplicate=$duplicate, reason=$reason, details=$details]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.signedId != null) {
      json[r'signed_id'] = this.signedId;
    }
    if (this.filename != null) {
      json[r'filename'] = this.filename;
    }
    if (this.byteSize != null) {
      json[r'byte_size'] = this.byteSize;
    }
    if (this.checksum != null) {
      json[r'checksum'] = this.checksum;
    }
    if (this.contentType != null) {
      json[r'content_type'] = this.contentType;
    }
    if (this.serviceName != null) {
      json[r'service_name'] = this.serviceName;
    }
    if (this.directUpload != null) {
      json[r'direct_upload'] = this.directUpload;
    }
    if (this.file != null) {
      json[r'file'] = this.file;
    }
    if (this.version != null) {
      json[r'version'] = this.version;
    }
    if (this.skipped != null) {
      json[r'skipped'] = this.skipped;
    }
    if (this.duplicate != null) {
      json[r'duplicate'] = this.duplicate;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    }
      json[r'details'] = this.details;
    return json;
  }

  /// Returns a new [PreparedFileUpload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PreparedFileUpload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return PreparedFileUpload(
        signedId: mapValueOfType<String>(json, r'signed_id'),
        filename: mapValueOfType<String>(json, r'filename'),
        byteSize: mapValueOfType<int>(json, r'byte_size'),
        checksum: mapValueOfType<String>(json, r'checksum'),
        contentType: mapValueOfType<String>(json, r'content_type'),
        serviceName: mapValueOfType<String>(json, r'service_name'),
        directUpload: StorageUpload.fromJson(json[r'direct_upload']),
        file: MailboxFile.fromJson(json[r'file']),
        version: FileVersion.fromJson(json[r'version']),
        skipped: mapValueOfType<bool>(json, r'skipped'),
        duplicate: mapValueOfType<bool>(json, r'duplicate'),
        reason: mapValueOfType<String>(json, r'reason'),
        details: mapCastOfType<String, Object?>(json, r'details') ?? const {},
      );
    }
    return null;
  }

  static List<PreparedFileUpload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PreparedFileUpload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PreparedFileUpload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PreparedFileUpload> mapFromJson(dynamic json) {
    final map = <String, PreparedFileUpload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PreparedFileUpload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PreparedFileUpload-objects as value to a dart map
  static Map<String, List<PreparedFileUpload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PreparedFileUpload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PreparedFileUpload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


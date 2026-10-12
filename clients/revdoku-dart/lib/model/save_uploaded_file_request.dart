//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SaveUploadedFileRequest {
  /// Returns a new [SaveUploadedFileRequest] instance.
  SaveUploadedFileRequest({
    required this.path,
    required this.signedBlobId,
    this.name,
    this.role = const SaveUploadedFileRequestRoleEnum._('source'),
    this.existingFilePolicy = const SaveUploadedFileRequestExistingFilePolicyEnum._('replace'),
    this.expectedMailboxVersion,
    this.accountId,
    this.reason,
  });

  /// Destination path. An existing path receives a new version. Paths under _email/ return EMAIL_PATH_READ_ONLY.
  String path;

  /// data.signed_id from POST /v1/direct_uploads.
  String signedBlobId;

  /// Display name; defaults to the last path segment.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  SaveUploadedFileRequestRoleEnum role;

  SaveUploadedFileRequestExistingFilePolicyEnum existingFilePolicy;

  /// Mailbox version_id from your last read. A different current version returns MAILBOX_VERSION_CONFLICT and saves nothing.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? expectedMailboxVersion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SaveUploadedFileRequest &&
    other.path == path &&
    other.signedBlobId == signedBlobId &&
    other.name == name &&
    other.role == role &&
    other.existingFilePolicy == existingFilePolicy &&
    other.expectedMailboxVersion == expectedMailboxVersion &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (path.hashCode) +
    (signedBlobId.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (role.hashCode) +
    (existingFilePolicy.hashCode) +
    (expectedMailboxVersion == null ? 0 : expectedMailboxVersion!.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'SaveUploadedFileRequest[path=$path, signedBlobId=$signedBlobId, name=$name, role=$role, existingFilePolicy=$existingFilePolicy, expectedMailboxVersion=$expectedMailboxVersion, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'path'] = this.path;
      json[r'signed_blob_id'] = this.signedBlobId;
    if (this.name != null) {
      json[r'name'] = this.name;
    }
      json[r'role'] = this.role;
      json[r'existing_file_policy'] = this.existingFilePolicy;
    if (this.expectedMailboxVersion != null) {
      json[r'expected_mailbox_version'] = this.expectedMailboxVersion;
    }
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    return json;
  }

  /// Returns a new [SaveUploadedFileRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SaveUploadedFileRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'path'), 'Required key "SaveUploadedFileRequest[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "SaveUploadedFileRequest[path]" has a null value in JSON.');
        assert(json.containsKey(r'signed_blob_id'), 'Required key "SaveUploadedFileRequest[signed_blob_id]" is missing from JSON.');
        assert(json[r'signed_blob_id'] != null, 'Required key "SaveUploadedFileRequest[signed_blob_id]" has a null value in JSON.');
        return true;
      }());

      return SaveUploadedFileRequest(
        path: mapValueOfType<String>(json, r'path')!,
        signedBlobId: mapValueOfType<String>(json, r'signed_blob_id')!,
        name: mapValueOfType<String>(json, r'name'),
        role: SaveUploadedFileRequestRoleEnum.fromJson(json[r'role']) ?? const SaveUploadedFileRequestRoleEnum._('source'),
        existingFilePolicy: SaveUploadedFileRequestExistingFilePolicyEnum.fromJson(json[r'existing_file_policy']) ?? const SaveUploadedFileRequestExistingFilePolicyEnum._('replace'),
        expectedMailboxVersion: mapValueOfType<String>(json, r'expected_mailbox_version'),
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<SaveUploadedFileRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SaveUploadedFileRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SaveUploadedFileRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SaveUploadedFileRequest> mapFromJson(dynamic json) {
    final map = <String, SaveUploadedFileRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SaveUploadedFileRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SaveUploadedFileRequest-objects as value to a dart map
  static Map<String, List<SaveUploadedFileRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SaveUploadedFileRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SaveUploadedFileRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'path',
    'signed_blob_id',
  };
}


enum SaveUploadedFileRequestRoleEnum {
  source_._(r'source'),
  reference._(r'reference'),
  generated._(r'generated'),
  agentOutput._(r'agent_output'),
  export_._(r'export'),
  artifact._(r'artifact'),
  ;

  /// Instantiate a new enum with the provided value.
  const SaveUploadedFileRequestRoleEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SaveUploadedFileRequestRoleEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SaveUploadedFileRequestRoleEnum? fromJson(dynamic value) => SaveUploadedFileRequestRoleEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SaveUploadedFileRequestRoleEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SaveUploadedFileRequestRoleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SaveUploadedFileRequestRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SaveUploadedFileRequestRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SaveUploadedFileRequestRoleEnum] to String,
/// and [decode] dynamic data back to [SaveUploadedFileRequestRoleEnum].
class SaveUploadedFileRequestRoleEnumTypeTransformer {
  factory SaveUploadedFileRequestRoleEnumTypeTransformer() => _instance ??= const SaveUploadedFileRequestRoleEnumTypeTransformer._();

  const SaveUploadedFileRequestRoleEnumTypeTransformer._();

  String encode(SaveUploadedFileRequestRoleEnum data) => data._value;

  /// Returns the instance of [SaveUploadedFileRequestRoleEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SaveUploadedFileRequestRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SaveUploadedFileRequestRoleEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'source': return SaveUploadedFileRequestRoleEnum.source_;
        case r'reference': return SaveUploadedFileRequestRoleEnum.reference;
        case r'generated': return SaveUploadedFileRequestRoleEnum.generated;
        case r'agent_output': return SaveUploadedFileRequestRoleEnum.agentOutput;
        case r'export': return SaveUploadedFileRequestRoleEnum.export_;
        case r'artifact': return SaveUploadedFileRequestRoleEnum.artifact;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SaveUploadedFileRequestRoleEnumTypeTransformer? _instance;
}



enum SaveUploadedFileRequestExistingFilePolicyEnum {
  replace._(r'replace'),
  skip._(r'skip'),
  ;

  /// Instantiate a new enum with the provided value.
  const SaveUploadedFileRequestExistingFilePolicyEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SaveUploadedFileRequestExistingFilePolicyEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SaveUploadedFileRequestExistingFilePolicyEnum? fromJson(dynamic value) => SaveUploadedFileRequestExistingFilePolicyEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SaveUploadedFileRequestExistingFilePolicyEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SaveUploadedFileRequestExistingFilePolicyEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SaveUploadedFileRequestExistingFilePolicyEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SaveUploadedFileRequestExistingFilePolicyEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SaveUploadedFileRequestExistingFilePolicyEnum] to String,
/// and [decode] dynamic data back to [SaveUploadedFileRequestExistingFilePolicyEnum].
class SaveUploadedFileRequestExistingFilePolicyEnumTypeTransformer {
  factory SaveUploadedFileRequestExistingFilePolicyEnumTypeTransformer() => _instance ??= const SaveUploadedFileRequestExistingFilePolicyEnumTypeTransformer._();

  const SaveUploadedFileRequestExistingFilePolicyEnumTypeTransformer._();

  String encode(SaveUploadedFileRequestExistingFilePolicyEnum data) => data._value;

  /// Returns the instance of [SaveUploadedFileRequestExistingFilePolicyEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SaveUploadedFileRequestExistingFilePolicyEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SaveUploadedFileRequestExistingFilePolicyEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'replace': return SaveUploadedFileRequestExistingFilePolicyEnum.replace;
        case r'skip': return SaveUploadedFileRequestExistingFilePolicyEnum.skip;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SaveUploadedFileRequestExistingFilePolicyEnumTypeTransformer? _instance;
}



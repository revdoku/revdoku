//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CreateUploadSessionRequest {
  /// Returns a new [CreateUploadSessionRequest] instance.
  CreateUploadSessionRequest({
    this.files = const [],
    this.expectedFileCount,
    this.clientSessionKey,
    this.existingFilePolicy = const CreateUploadSessionRequestExistingFilePolicyEnum._('replace'),
    this.expectedMailboxVersion,
    this.accountId,
    this.reason,
  });

  /// Optional first batch. Send the rest with POST .../uploads.
  List<UploadSessionFile> files;

  /// Total files you will upload in this session. Used for progress.
  ///
  /// Minimum value: 1
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? expectedFileCount;

  /// Your own key for this batch. Repeating it with the same credential while the session is pending returns that session instead of a new one.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientSessionKey;

  /// skip keeps existing files at the same paths.
  CreateUploadSessionRequestExistingFilePolicyEnum existingFilePolicy;

  /// Mailbox version_id from your last read. A different current version returns MAILBOX_VERSION_CONFLICT.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? expectedMailboxVersion;

  /// Select another granted account for this request.
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
  bool operator ==(Object other) => identical(this, other) || other is CreateUploadSessionRequest &&
    _deepEquality.equals(other.files, files) &&
    other.expectedFileCount == expectedFileCount &&
    other.clientSessionKey == clientSessionKey &&
    other.existingFilePolicy == existingFilePolicy &&
    other.expectedMailboxVersion == expectedMailboxVersion &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (files.hashCode) +
    (expectedFileCount == null ? 0 : expectedFileCount!.hashCode) +
    (clientSessionKey == null ? 0 : clientSessionKey!.hashCode) +
    (existingFilePolicy.hashCode) +
    (expectedMailboxVersion == null ? 0 : expectedMailboxVersion!.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'CreateUploadSessionRequest[files=$files, expectedFileCount=$expectedFileCount, clientSessionKey=$clientSessionKey, existingFilePolicy=$existingFilePolicy, expectedMailboxVersion=$expectedMailboxVersion, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'files'] = this.files;
    if (this.expectedFileCount != null) {
      json[r'expected_file_count'] = this.expectedFileCount;
    }
    if (this.clientSessionKey != null) {
      json[r'client_session_key'] = this.clientSessionKey;
    }
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

  /// Returns a new [CreateUploadSessionRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateUploadSessionRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return CreateUploadSessionRequest(
        files: UploadSessionFile.listFromJson(json[r'files']),
        expectedFileCount: mapValueOfType<int>(json, r'expected_file_count'),
        clientSessionKey: mapValueOfType<String>(json, r'client_session_key'),
        existingFilePolicy: CreateUploadSessionRequestExistingFilePolicyEnum.fromJson(json[r'existing_file_policy']) ?? const CreateUploadSessionRequestExistingFilePolicyEnum._('replace'),
        expectedMailboxVersion: mapValueOfType<String>(json, r'expected_mailbox_version'),
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<CreateUploadSessionRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateUploadSessionRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateUploadSessionRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateUploadSessionRequest> mapFromJson(dynamic json) {
    final map = <String, CreateUploadSessionRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateUploadSessionRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateUploadSessionRequest-objects as value to a dart map
  static Map<String, List<CreateUploadSessionRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateUploadSessionRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateUploadSessionRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

/// skip keeps existing files at the same paths.
enum CreateUploadSessionRequestExistingFilePolicyEnum {
  replace._(r'replace'),
  skip._(r'skip'),
  ;

  /// Instantiate a new enum with the provided value.
  const CreateUploadSessionRequestExistingFilePolicyEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CreateUploadSessionRequestExistingFilePolicyEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CreateUploadSessionRequestExistingFilePolicyEnum? fromJson(dynamic value) => CreateUploadSessionRequestExistingFilePolicyEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CreateUploadSessionRequestExistingFilePolicyEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CreateUploadSessionRequestExistingFilePolicyEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateUploadSessionRequestExistingFilePolicyEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateUploadSessionRequestExistingFilePolicyEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateUploadSessionRequestExistingFilePolicyEnum] to String,
/// and [decode] dynamic data back to [CreateUploadSessionRequestExistingFilePolicyEnum].
class CreateUploadSessionRequestExistingFilePolicyEnumTypeTransformer {
  factory CreateUploadSessionRequestExistingFilePolicyEnumTypeTransformer() => _instance ??= const CreateUploadSessionRequestExistingFilePolicyEnumTypeTransformer._();

  const CreateUploadSessionRequestExistingFilePolicyEnumTypeTransformer._();

  String encode(CreateUploadSessionRequestExistingFilePolicyEnum data) => data._value;

  /// Returns the instance of [CreateUploadSessionRequestExistingFilePolicyEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateUploadSessionRequestExistingFilePolicyEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is CreateUploadSessionRequestExistingFilePolicyEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'replace': return CreateUploadSessionRequestExistingFilePolicyEnum.replace;
        case r'skip': return CreateUploadSessionRequestExistingFilePolicyEnum.skip;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CreateUploadSessionRequestExistingFilePolicyEnumTypeTransformer? _instance;
}



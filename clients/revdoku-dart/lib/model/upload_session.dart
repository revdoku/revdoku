//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UploadSession {
  /// Returns a new [UploadSession] instance.
  UploadSession({
    required this.id,
    required this.mailboxId,
    required this.status,
    this.baseMailboxVersionId,
    this.targetMailboxVersionId,
    this.uploadsExpireAt,
    this.sessionClosedAt,
    this.filesCount,
    this.pendingFilesCount,
    this.uploadedFilesCount,
    this.finalizedFilesCount,
    this.skippedFilesCount,
    this.skippedCodeCounts = const {},
    this.failedFilesCount,
  });

  String id;

  String mailboxId;

  /// pending accepts uploads. failed means canceled; its unsaved files were discarded.
  UploadSessionStatusEnum status;

  /// Mailbox version when the session started.
  String? baseMailboxVersionId;

  /// Mailbox version created by the final save.
  String? targetMailboxVersionId;

  /// Unsaved uploads are discarded after this time.
  DateTime? uploadsExpireAt;

  DateTime? sessionClosedAt;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? filesCount;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? pendingFilesCount;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? uploadedFilesCount;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? finalizedFilesCount;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? skippedFilesCount;

  /// Skipped files per skip code.
  Map<String, int> skippedCodeCounts;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? failedFilesCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadSession &&
    other.id == id &&
    other.mailboxId == mailboxId &&
    other.status == status &&
    other.baseMailboxVersionId == baseMailboxVersionId &&
    other.targetMailboxVersionId == targetMailboxVersionId &&
    other.uploadsExpireAt == uploadsExpireAt &&
    other.sessionClosedAt == sessionClosedAt &&
    other.filesCount == filesCount &&
    other.pendingFilesCount == pendingFilesCount &&
    other.uploadedFilesCount == uploadedFilesCount &&
    other.finalizedFilesCount == finalizedFilesCount &&
    other.skippedFilesCount == skippedFilesCount &&
    _deepEquality.equals(other.skippedCodeCounts, skippedCodeCounts) &&
    other.failedFilesCount == failedFilesCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (mailboxId.hashCode) +
    (status.hashCode) +
    (baseMailboxVersionId == null ? 0 : baseMailboxVersionId!.hashCode) +
    (targetMailboxVersionId == null ? 0 : targetMailboxVersionId!.hashCode) +
    (uploadsExpireAt == null ? 0 : uploadsExpireAt!.hashCode) +
    (sessionClosedAt == null ? 0 : sessionClosedAt!.hashCode) +
    (filesCount == null ? 0 : filesCount!.hashCode) +
    (pendingFilesCount == null ? 0 : pendingFilesCount!.hashCode) +
    (uploadedFilesCount == null ? 0 : uploadedFilesCount!.hashCode) +
    (finalizedFilesCount == null ? 0 : finalizedFilesCount!.hashCode) +
    (skippedFilesCount == null ? 0 : skippedFilesCount!.hashCode) +
    (skippedCodeCounts.hashCode) +
    (failedFilesCount == null ? 0 : failedFilesCount!.hashCode);

  @override
  String toString() => 'UploadSession[id=$id, mailboxId=$mailboxId, status=$status, baseMailboxVersionId=$baseMailboxVersionId, targetMailboxVersionId=$targetMailboxVersionId, uploadsExpireAt=$uploadsExpireAt, sessionClosedAt=$sessionClosedAt, filesCount=$filesCount, pendingFilesCount=$pendingFilesCount, uploadedFilesCount=$uploadedFilesCount, finalizedFilesCount=$finalizedFilesCount, skippedFilesCount=$skippedFilesCount, skippedCodeCounts=$skippedCodeCounts, failedFilesCount=$failedFilesCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'mailbox_id'] = this.mailboxId;
      json[r'status'] = this.status;
    if (this.baseMailboxVersionId != null) {
      json[r'base_mailbox_version_id'] = this.baseMailboxVersionId;
    } else {
      json[r'base_mailbox_version_id'] = null;
    }
    if (this.targetMailboxVersionId != null) {
      json[r'target_mailbox_version_id'] = this.targetMailboxVersionId;
    } else {
      json[r'target_mailbox_version_id'] = null;
    }
    if (this.uploadsExpireAt != null) {
      json[r'uploads_expire_at'] = this.uploadsExpireAt!.toUtc().toIso8601String();
    } else {
      json[r'uploads_expire_at'] = null;
    }
    if (this.sessionClosedAt != null) {
      json[r'session_closed_at'] = this.sessionClosedAt!.toUtc().toIso8601String();
    } else {
      json[r'session_closed_at'] = null;
    }
    if (this.filesCount != null) {
      json[r'files_count'] = this.filesCount;
    }
    if (this.pendingFilesCount != null) {
      json[r'pending_files_count'] = this.pendingFilesCount;
    }
    if (this.uploadedFilesCount != null) {
      json[r'uploaded_files_count'] = this.uploadedFilesCount;
    }
    if (this.finalizedFilesCount != null) {
      json[r'finalized_files_count'] = this.finalizedFilesCount;
    }
    if (this.skippedFilesCount != null) {
      json[r'skipped_files_count'] = this.skippedFilesCount;
    }
      json[r'skipped_code_counts'] = this.skippedCodeCounts;
    if (this.failedFilesCount != null) {
      json[r'failed_files_count'] = this.failedFilesCount;
    }
    return json;
  }

  /// Returns a new [UploadSession] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadSession? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "UploadSession[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "UploadSession[id]" has a null value in JSON.');
        assert(json.containsKey(r'mailbox_id'), 'Required key "UploadSession[mailbox_id]" is missing from JSON.');
        assert(json[r'mailbox_id'] != null, 'Required key "UploadSession[mailbox_id]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "UploadSession[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "UploadSession[status]" has a null value in JSON.');
        return true;
      }());

      return UploadSession(
        id: mapValueOfType<String>(json, r'id')!,
        mailboxId: mapValueOfType<String>(json, r'mailbox_id')!,
        status: UploadSessionStatusEnum.fromJson(json[r'status'])!,
        baseMailboxVersionId: mapValueOfType<String>(json, r'base_mailbox_version_id'),
        targetMailboxVersionId: mapValueOfType<String>(json, r'target_mailbox_version_id'),
        uploadsExpireAt: mapDateTime(json, r'uploads_expire_at', r''),
        sessionClosedAt: mapDateTime(json, r'session_closed_at', r''),
        filesCount: mapValueOfType<int>(json, r'files_count'),
        pendingFilesCount: mapValueOfType<int>(json, r'pending_files_count'),
        uploadedFilesCount: mapValueOfType<int>(json, r'uploaded_files_count'),
        finalizedFilesCount: mapValueOfType<int>(json, r'finalized_files_count'),
        skippedFilesCount: mapValueOfType<int>(json, r'skipped_files_count'),
        skippedCodeCounts: mapCastOfType<String, int>(json, r'skipped_code_counts') ?? const {},
        failedFilesCount: mapValueOfType<int>(json, r'failed_files_count'),
      );
    }
    return null;
  }

  static List<UploadSession> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadSession>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadSession.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadSession> mapFromJson(dynamic json) {
    final map = <String, UploadSession>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadSession.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadSession-objects as value to a dart map
  static Map<String, List<UploadSession>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadSession>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadSession.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'mailbox_id',
    'status',
  };
}

/// pending accepts uploads. failed means canceled; its unsaved files were discarded.
enum UploadSessionStatusEnum {
  pending._(r'pending'),
  finalized._(r'finalized'),
  expired._(r'expired'),
  failed._(r'failed'),
  ;

  /// Instantiate a new enum with the provided value.
  const UploadSessionStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [UploadSessionStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static UploadSessionStatusEnum? fromJson(dynamic value) => UploadSessionStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [UploadSessionStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<UploadSessionStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadSessionStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadSessionStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UploadSessionStatusEnum] to String,
/// and [decode] dynamic data back to [UploadSessionStatusEnum].
class UploadSessionStatusEnumTypeTransformer {
  factory UploadSessionStatusEnumTypeTransformer() => _instance ??= const UploadSessionStatusEnumTypeTransformer._();

  const UploadSessionStatusEnumTypeTransformer._();

  String encode(UploadSessionStatusEnum data) => data._value;

  /// Returns the instance of [UploadSessionStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UploadSessionStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is UploadSessionStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'pending': return UploadSessionStatusEnum.pending;
        case r'finalized': return UploadSessionStatusEnum.finalized;
        case r'expired': return UploadSessionStatusEnum.expired;
        case r'failed': return UploadSessionStatusEnum.failed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static UploadSessionStatusEnumTypeTransformer? _instance;
}



//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UploadSessionResult {
  /// Returns a new [UploadSessionResult] instance.
  UploadSessionResult({
    required this.mailboxUploadSession,
    this.uploads = const [],
    this.uploaded = const [],
    required this.uploadedCount,
    this.uploadedTruncated,
    this.createdCount,
    this.updatedCount,
    this.skipped = const [],
    required this.skippedCount,
    this.skippedTruncated,
    this.finalizePending,
    this.remainingFilesCount,
    this.message,
  });

  UploadSession mailboxUploadSession;

  /// Create and uploads only: storage targets for the files that need bytes.
  List<UploadSessionUpload> uploads;

  /// Files saved by this request (at most 250).
  List<UploadedFile> uploaded;

  /// Minimum value: 0
  int uploadedCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? uploadedTruncated;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? createdCount;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? updatedCount;

  /// Files left unchanged, for example identical content (DUPLICATE_FILE_VERSION).
  List<FileUploadSkip> skipped;

  /// Minimum value: 0
  int skippedCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? skippedTruncated;

  /// Finalize only: true when more files remain. Call finalize again after Retry-After.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? finalizePending;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? remainingFilesCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadSessionResult &&
    other.mailboxUploadSession == mailboxUploadSession &&
    _deepEquality.equals(other.uploads, uploads) &&
    _deepEquality.equals(other.uploaded, uploaded) &&
    other.uploadedCount == uploadedCount &&
    other.uploadedTruncated == uploadedTruncated &&
    other.createdCount == createdCount &&
    other.updatedCount == updatedCount &&
    _deepEquality.equals(other.skipped, skipped) &&
    other.skippedCount == skippedCount &&
    other.skippedTruncated == skippedTruncated &&
    other.finalizePending == finalizePending &&
    other.remainingFilesCount == remainingFilesCount &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mailboxUploadSession.hashCode) +
    (uploads.hashCode) +
    (uploaded.hashCode) +
    (uploadedCount.hashCode) +
    (uploadedTruncated == null ? 0 : uploadedTruncated!.hashCode) +
    (createdCount == null ? 0 : createdCount!.hashCode) +
    (updatedCount == null ? 0 : updatedCount!.hashCode) +
    (skipped.hashCode) +
    (skippedCount.hashCode) +
    (skippedTruncated == null ? 0 : skippedTruncated!.hashCode) +
    (finalizePending == null ? 0 : finalizePending!.hashCode) +
    (remainingFilesCount == null ? 0 : remainingFilesCount!.hashCode) +
    (message == null ? 0 : message!.hashCode);

  @override
  String toString() => 'UploadSessionResult[mailboxUploadSession=$mailboxUploadSession, uploads=$uploads, uploaded=$uploaded, uploadedCount=$uploadedCount, uploadedTruncated=$uploadedTruncated, createdCount=$createdCount, updatedCount=$updatedCount, skipped=$skipped, skippedCount=$skippedCount, skippedTruncated=$skippedTruncated, finalizePending=$finalizePending, remainingFilesCount=$remainingFilesCount, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mailbox_upload_session'] = this.mailboxUploadSession;
      json[r'uploads'] = this.uploads;
      json[r'uploaded'] = this.uploaded;
      json[r'uploaded_count'] = this.uploadedCount;
    if (this.uploadedTruncated != null) {
      json[r'uploaded_truncated'] = this.uploadedTruncated;
    }
    if (this.createdCount != null) {
      json[r'created_count'] = this.createdCount;
    }
    if (this.updatedCount != null) {
      json[r'updated_count'] = this.updatedCount;
    }
      json[r'skipped'] = this.skipped;
      json[r'skipped_count'] = this.skippedCount;
    if (this.skippedTruncated != null) {
      json[r'skipped_truncated'] = this.skippedTruncated;
    }
    if (this.finalizePending != null) {
      json[r'finalize_pending'] = this.finalizePending;
    }
    if (this.remainingFilesCount != null) {
      json[r'remaining_files_count'] = this.remainingFilesCount;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    }
    return json;
  }

  /// Returns a new [UploadSessionResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadSessionResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mailbox_upload_session'), 'Required key "UploadSessionResult[mailbox_upload_session]" is missing from JSON.');
        assert(json[r'mailbox_upload_session'] != null, 'Required key "UploadSessionResult[mailbox_upload_session]" has a null value in JSON.');
        assert(json.containsKey(r'uploaded'), 'Required key "UploadSessionResult[uploaded]" is missing from JSON.');
        assert(json[r'uploaded'] != null, 'Required key "UploadSessionResult[uploaded]" has a null value in JSON.');
        assert(json.containsKey(r'uploaded_count'), 'Required key "UploadSessionResult[uploaded_count]" is missing from JSON.');
        assert(json[r'uploaded_count'] != null, 'Required key "UploadSessionResult[uploaded_count]" has a null value in JSON.');
        assert(json.containsKey(r'skipped'), 'Required key "UploadSessionResult[skipped]" is missing from JSON.');
        assert(json[r'skipped'] != null, 'Required key "UploadSessionResult[skipped]" has a null value in JSON.');
        assert(json.containsKey(r'skipped_count'), 'Required key "UploadSessionResult[skipped_count]" is missing from JSON.');
        assert(json[r'skipped_count'] != null, 'Required key "UploadSessionResult[skipped_count]" has a null value in JSON.');
        return true;
      }());

      return UploadSessionResult(
        mailboxUploadSession: UploadSession.fromJson(json[r'mailbox_upload_session'])!,
        uploads: UploadSessionUpload.listFromJson(json[r'uploads']),
        uploaded: UploadedFile.listFromJson(json[r'uploaded']),
        uploadedCount: mapValueOfType<int>(json, r'uploaded_count')!,
        uploadedTruncated: mapValueOfType<bool>(json, r'uploaded_truncated'),
        createdCount: mapValueOfType<int>(json, r'created_count'),
        updatedCount: mapValueOfType<int>(json, r'updated_count'),
        skipped: FileUploadSkip.listFromJson(json[r'skipped']),
        skippedCount: mapValueOfType<int>(json, r'skipped_count')!,
        skippedTruncated: mapValueOfType<bool>(json, r'skipped_truncated'),
        finalizePending: mapValueOfType<bool>(json, r'finalize_pending'),
        remainingFilesCount: mapValueOfType<int>(json, r'remaining_files_count'),
        message: mapValueOfType<String>(json, r'message'),
      );
    }
    return null;
  }

  static List<UploadSessionResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadSessionResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadSessionResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadSessionResult> mapFromJson(dynamic json) {
    final map = <String, UploadSessionResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadSessionResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadSessionResult-objects as value to a dart map
  static Map<String, List<UploadSessionResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadSessionResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadSessionResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mailbox_upload_session',
    'uploaded',
    'uploaded_count',
    'skipped',
    'skipped_count',
  };
}


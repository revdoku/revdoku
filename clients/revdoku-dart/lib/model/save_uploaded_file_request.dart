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
    this.accountId,
    this.expectedMailboxRevisionId,
    this.reason,
  });

  String path;

  String signedBlobId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? expectedMailboxRevisionId;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SaveUploadedFileRequest &&
    other.path == path &&
    other.signedBlobId == signedBlobId &&
    other.accountId == accountId &&
    other.expectedMailboxRevisionId == expectedMailboxRevisionId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (path.hashCode) +
    (signedBlobId.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (expectedMailboxRevisionId == null ? 0 : expectedMailboxRevisionId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'SaveUploadedFileRequest[path=$path, signedBlobId=$signedBlobId, accountId=$accountId, expectedMailboxRevisionId=$expectedMailboxRevisionId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'path'] = this.path;
      json[r'signed_blob_id'] = this.signedBlobId;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.expectedMailboxRevisionId != null) {
      json[r'expected_mailbox_revision_id'] = this.expectedMailboxRevisionId;
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
        accountId: mapValueOfType<String>(json, r'account_id'),
        expectedMailboxRevisionId: mapValueOfType<String>(json, r'expected_mailbox_revision_id'),
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


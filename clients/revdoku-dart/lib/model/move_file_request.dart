//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MoveFileRequest {
  /// Returns a new [MoveFileRequest] instance.
  MoveFileRequest({
    this.targetMailboxId,
    this.targetPath,
    this.targetFolder,
    this.accountId,
    this.reason,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? targetMailboxId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? targetPath;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? targetFolder;

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
  bool operator ==(Object other) => identical(this, other) || other is MoveFileRequest &&
    other.targetMailboxId == targetMailboxId &&
    other.targetPath == targetPath &&
    other.targetFolder == targetFolder &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (targetMailboxId == null ? 0 : targetMailboxId!.hashCode) +
    (targetPath == null ? 0 : targetPath!.hashCode) +
    (targetFolder == null ? 0 : targetFolder!.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'MoveFileRequest[targetMailboxId=$targetMailboxId, targetPath=$targetPath, targetFolder=$targetFolder, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.targetMailboxId != null) {
      json[r'target_mailbox_id'] = this.targetMailboxId;
    }
    if (this.targetPath != null) {
      json[r'target_path'] = this.targetPath;
    }
    if (this.targetFolder != null) {
      json[r'target_folder'] = this.targetFolder;
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

  /// Returns a new [MoveFileRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MoveFileRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MoveFileRequest(
        targetMailboxId: mapValueOfType<String>(json, r'target_mailbox_id'),
        targetPath: mapValueOfType<String>(json, r'target_path'),
        targetFolder: mapValueOfType<String>(json, r'target_folder'),
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<MoveFileRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MoveFileRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MoveFileRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MoveFileRequest> mapFromJson(dynamic json) {
    final map = <String, MoveFileRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MoveFileRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MoveFileRequest-objects as value to a dart map
  static Map<String, List<MoveFileRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MoveFileRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MoveFileRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


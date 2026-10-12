//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UpdateMailboxRequest {
  /// Returns a new [UpdateMailboxRequest] instance.
  UpdateMailboxRequest({
    required this.mailbox,
    this.expectedMetadataVersion,
    this.accountId,
    this.reason,
  });

  MailboxUpdate mailbox;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? expectedMetadataVersion;

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
  bool operator ==(Object other) => identical(this, other) || other is UpdateMailboxRequest &&
    other.mailbox == mailbox &&
    other.expectedMetadataVersion == expectedMetadataVersion &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mailbox.hashCode) +
    (expectedMetadataVersion == null ? 0 : expectedMetadataVersion!.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'UpdateMailboxRequest[mailbox=$mailbox, expectedMetadataVersion=$expectedMetadataVersion, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mailbox'] = this.mailbox;
    if (this.expectedMetadataVersion != null) {
      json[r'expected_metadata_version'] = this.expectedMetadataVersion;
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

  /// Returns a new [UpdateMailboxRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateMailboxRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mailbox'), 'Required key "UpdateMailboxRequest[mailbox]" is missing from JSON.');
        assert(json[r'mailbox'] != null, 'Required key "UpdateMailboxRequest[mailbox]" has a null value in JSON.');
        return true;
      }());

      return UpdateMailboxRequest(
        mailbox: MailboxUpdate.fromJson(json[r'mailbox'])!,
        expectedMetadataVersion: mapValueOfType<String>(json, r'expected_metadata_version'),
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<UpdateMailboxRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateMailboxRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateMailboxRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateMailboxRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateMailboxRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateMailboxRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateMailboxRequest-objects as value to a dart map
  static Map<String, List<UpdateMailboxRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateMailboxRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateMailboxRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mailbox',
  };
}


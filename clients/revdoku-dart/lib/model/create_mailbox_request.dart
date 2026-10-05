//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CreateMailboxRequest {
  /// Returns a new [CreateMailboxRequest] instance.
  CreateMailboxRequest({
    this.accountId,
    required this.mailbox,
    this.reason,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  CreateMailboxRequestMailbox mailbox;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateMailboxRequest &&
    other.accountId == accountId &&
    other.mailbox == mailbox &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId == null ? 0 : accountId!.hashCode) +
    (mailbox.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'CreateMailboxRequest[accountId=$accountId, mailbox=$mailbox, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
      json[r'mailbox'] = this.mailbox;
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    return json;
  }

  /// Returns a new [CreateMailboxRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateMailboxRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mailbox'), 'Required key "CreateMailboxRequest[mailbox]" is missing from JSON.');
        assert(json[r'mailbox'] != null, 'Required key "CreateMailboxRequest[mailbox]" has a null value in JSON.');
        return true;
      }());

      return CreateMailboxRequest(
        accountId: mapValueOfType<String>(json, r'account_id'),
        mailbox: CreateMailboxRequestMailbox.fromJson(json[r'mailbox'])!,
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<CreateMailboxRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateMailboxRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateMailboxRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateMailboxRequest> mapFromJson(dynamic json) {
    final map = <String, CreateMailboxRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateMailboxRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateMailboxRequest-objects as value to a dart map
  static Map<String, List<CreateMailboxRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateMailboxRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateMailboxRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mailbox',
  };
}


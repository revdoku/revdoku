//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailReceivedEventData {
  /// Returns a new [EmailReceivedEventData] instance.
  EmailReceivedEventData({
    required this.accountId,
    required this.mailboxId,
    required this.emailId,
    required this.receivedAt,
    required this.attachmentCount,
  });

  String accountId;

  String mailboxId;

  String emailId;

  DateTime receivedAt;

  /// Minimum value: 0
  int attachmentCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailReceivedEventData &&
    other.accountId == accountId &&
    other.mailboxId == mailboxId &&
    other.emailId == emailId &&
    other.receivedAt == receivedAt &&
    other.attachmentCount == attachmentCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (mailboxId.hashCode) +
    (emailId.hashCode) +
    (receivedAt.hashCode) +
    (attachmentCount.hashCode);

  @override
  String toString() => 'EmailReceivedEventData[accountId=$accountId, mailboxId=$mailboxId, emailId=$emailId, receivedAt=$receivedAt, attachmentCount=$attachmentCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'mailbox_id'] = this.mailboxId;
      json[r'email_id'] = this.emailId;
      json[r'received_at'] = this.receivedAt.toUtc().toIso8601String();
      json[r'attachment_count'] = this.attachmentCount;
    return json;
  }

  /// Returns a new [EmailReceivedEventData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailReceivedEventData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'account_id'), 'Required key "EmailReceivedEventData[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "EmailReceivedEventData[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'mailbox_id'), 'Required key "EmailReceivedEventData[mailbox_id]" is missing from JSON.');
        assert(json[r'mailbox_id'] != null, 'Required key "EmailReceivedEventData[mailbox_id]" has a null value in JSON.');
        assert(json.containsKey(r'email_id'), 'Required key "EmailReceivedEventData[email_id]" is missing from JSON.');
        assert(json[r'email_id'] != null, 'Required key "EmailReceivedEventData[email_id]" has a null value in JSON.');
        assert(json.containsKey(r'received_at'), 'Required key "EmailReceivedEventData[received_at]" is missing from JSON.');
        assert(json[r'received_at'] != null, 'Required key "EmailReceivedEventData[received_at]" has a null value in JSON.');
        assert(json.containsKey(r'attachment_count'), 'Required key "EmailReceivedEventData[attachment_count]" is missing from JSON.');
        assert(json[r'attachment_count'] != null, 'Required key "EmailReceivedEventData[attachment_count]" has a null value in JSON.');
        return true;
      }());

      return EmailReceivedEventData(
        accountId: mapValueOfType<String>(json, r'account_id')!,
        mailboxId: mapValueOfType<String>(json, r'mailbox_id')!,
        emailId: mapValueOfType<String>(json, r'email_id')!,
        receivedAt: mapDateTime(json, r'received_at', r'')!,
        attachmentCount: mapValueOfType<int>(json, r'attachment_count')!,
      );
    }
    return null;
  }

  static List<EmailReceivedEventData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailReceivedEventData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailReceivedEventData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailReceivedEventData> mapFromJson(dynamic json) {
    final map = <String, EmailReceivedEventData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailReceivedEventData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailReceivedEventData-objects as value to a dart map
  static Map<String, List<EmailReceivedEventData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailReceivedEventData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailReceivedEventData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'mailbox_id',
    'email_id',
    'received_at',
    'attachment_count',
  };
}


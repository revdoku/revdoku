//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmail {
  /// Returns a new [MailboxEmail] instance.
  MailboxEmail({
    this.address,
    required this.messageCount,
    required this.unreadCount,
    required this.lastReceivedAt,
    required this.receivingEnabled,
    this.blockedReason,
    required this.sendingEnabled,
    this.sendingBlockedReason,
  });

  /// Primary address. Present when the credential has write access to the mailbox. Use it as the mailbox label.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? address;

  /// Emails currently stored. Null while the email index is being prepared.
  ///
  /// Minimum value: 0
  int? messageCount;

  /// Stored emails with shared unread status. Null while the email index is being prepared.
  ///
  /// Minimum value: 0
  int? unreadCount;

  /// Receipt time of the latest saved email; null before the first email.
  DateTime? lastReceivedAt;

  /// Whether the mailbox can receive email now.
  bool receivingEnabled;

  /// Why receiving is unavailable. Omitted when receiving_enabled is true.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? blockedReason;

  /// Whether the mailbox can send replies now.
  bool sendingEnabled;

  /// Why sending is unavailable. Omitted when sending_enabled is true.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sendingBlockedReason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmail &&
    other.address == address &&
    other.messageCount == messageCount &&
    other.unreadCount == unreadCount &&
    other.lastReceivedAt == lastReceivedAt &&
    other.receivingEnabled == receivingEnabled &&
    other.blockedReason == blockedReason &&
    other.sendingEnabled == sendingEnabled &&
    other.sendingBlockedReason == sendingBlockedReason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (address == null ? 0 : address!.hashCode) +
    (messageCount == null ? 0 : messageCount!.hashCode) +
    (unreadCount == null ? 0 : unreadCount!.hashCode) +
    (lastReceivedAt == null ? 0 : lastReceivedAt!.hashCode) +
    (receivingEnabled.hashCode) +
    (blockedReason == null ? 0 : blockedReason!.hashCode) +
    (sendingEnabled.hashCode) +
    (sendingBlockedReason == null ? 0 : sendingBlockedReason!.hashCode);

  @override
  String toString() => 'MailboxEmail[address=$address, messageCount=$messageCount, unreadCount=$unreadCount, lastReceivedAt=$lastReceivedAt, receivingEnabled=$receivingEnabled, blockedReason=$blockedReason, sendingEnabled=$sendingEnabled, sendingBlockedReason=$sendingBlockedReason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.address != null) {
      json[r'address'] = this.address;
    }
    if (this.messageCount != null) {
      json[r'message_count'] = this.messageCount;
    } else {
      json[r'message_count'] = null;
    }
    if (this.unreadCount != null) {
      json[r'unread_count'] = this.unreadCount;
    } else {
      json[r'unread_count'] = null;
    }
    if (this.lastReceivedAt != null) {
      json[r'last_received_at'] = this.lastReceivedAt!.toUtc().toIso8601String();
    } else {
      json[r'last_received_at'] = null;
    }
      json[r'receiving_enabled'] = this.receivingEnabled;
    if (this.blockedReason != null) {
      json[r'blocked_reason'] = this.blockedReason;
    }
      json[r'sending_enabled'] = this.sendingEnabled;
    if (this.sendingBlockedReason != null) {
      json[r'sending_blocked_reason'] = this.sendingBlockedReason;
    }
    return json;
  }

  /// Returns a new [MailboxEmail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'message_count'), 'Required key "MailboxEmail[message_count]" is missing from JSON.');
        assert(json.containsKey(r'unread_count'), 'Required key "MailboxEmail[unread_count]" is missing from JSON.');
        assert(json.containsKey(r'last_received_at'), 'Required key "MailboxEmail[last_received_at]" is missing from JSON.');
        assert(json.containsKey(r'receiving_enabled'), 'Required key "MailboxEmail[receiving_enabled]" is missing from JSON.');
        assert(json[r'receiving_enabled'] != null, 'Required key "MailboxEmail[receiving_enabled]" has a null value in JSON.');
        assert(json.containsKey(r'sending_enabled'), 'Required key "MailboxEmail[sending_enabled]" is missing from JSON.');
        assert(json[r'sending_enabled'] != null, 'Required key "MailboxEmail[sending_enabled]" has a null value in JSON.');
        return true;
      }());

      return MailboxEmail(
        address: mapValueOfType<String>(json, r'address'),
        messageCount: mapValueOfType<int>(json, r'message_count'),
        unreadCount: mapValueOfType<int>(json, r'unread_count'),
        lastReceivedAt: mapDateTime(json, r'last_received_at', r''),
        receivingEnabled: mapValueOfType<bool>(json, r'receiving_enabled')!,
        blockedReason: mapValueOfType<String>(json, r'blocked_reason'),
        sendingEnabled: mapValueOfType<bool>(json, r'sending_enabled')!,
        sendingBlockedReason: mapValueOfType<String>(json, r'sending_blocked_reason'),
      );
    }
    return null;
  }

  static List<MailboxEmail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmail> mapFromJson(dynamic json) {
    final map = <String, MailboxEmail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmail-objects as value to a dart map
  static Map<String, List<MailboxEmail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message_count',
    'unread_count',
    'last_received_at',
    'receiving_enabled',
    'sending_enabled',
  };
}


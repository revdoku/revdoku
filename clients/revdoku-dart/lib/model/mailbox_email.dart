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
    this.receivedCount,
    this.lastReceivedAt,
    this.lastReceivedPath,
    this.blockedReason,
    this.availableDomains = const [],
    this.assignment,
    this.customization,
    this.receivingEnabled,
    this.senderAllowlist,
    this.username,
    this.sendingEnabled,
    this.aliases = const [],
  });

  String? address;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? receivedCount;

  DateTime? lastReceivedAt;

  /// Latest message folder with trailing slash; null before receipt. May become stale after manual file moves/deletion.
  String? lastReceivedPath;

  /// Why receiving is unavailable; omitted when receiving_enabled is true.
  String? blockedReason;

  List<MailboxEmailAvailableDomainsInner> availableDomains;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxEmailAssignment? assignment;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxEmailCustomization? customization;

  /// Whether this mailbox can currently receive email. False when configuration, account state, quota or routing prevents receiving.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? receivingEnabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailSenderAllowlist? senderAllowlist;

  String? username;

  /// Always false. Sending is not implemented.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? sendingEnabled;

  List<MailboxEmailAliasesInner> aliases;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmail &&
    other.address == address &&
    other.receivedCount == receivedCount &&
    other.lastReceivedAt == lastReceivedAt &&
    other.lastReceivedPath == lastReceivedPath &&
    other.blockedReason == blockedReason &&
    _deepEquality.equals(other.availableDomains, availableDomains) &&
    other.assignment == assignment &&
    other.customization == customization &&
    other.receivingEnabled == receivingEnabled &&
    other.senderAllowlist == senderAllowlist &&
    other.username == username &&
    other.sendingEnabled == sendingEnabled &&
    _deepEquality.equals(other.aliases, aliases);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (address == null ? 0 : address!.hashCode) +
    (receivedCount == null ? 0 : receivedCount!.hashCode) +
    (lastReceivedAt == null ? 0 : lastReceivedAt!.hashCode) +
    (lastReceivedPath == null ? 0 : lastReceivedPath!.hashCode) +
    (blockedReason == null ? 0 : blockedReason!.hashCode) +
    (availableDomains.hashCode) +
    (assignment == null ? 0 : assignment!.hashCode) +
    (customization == null ? 0 : customization!.hashCode) +
    (receivingEnabled == null ? 0 : receivingEnabled!.hashCode) +
    (senderAllowlist == null ? 0 : senderAllowlist!.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (sendingEnabled == null ? 0 : sendingEnabled!.hashCode) +
    (aliases.hashCode);

  @override
  String toString() => 'MailboxEmail[address=$address, receivedCount=$receivedCount, lastReceivedAt=$lastReceivedAt, lastReceivedPath=$lastReceivedPath, blockedReason=$blockedReason, availableDomains=$availableDomains, assignment=$assignment, customization=$customization, receivingEnabled=$receivingEnabled, senderAllowlist=$senderAllowlist, username=$username, sendingEnabled=$sendingEnabled, aliases=$aliases]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.address != null) {
      json[r'address'] = this.address;
    } else {
      json[r'address'] = null;
    }
    if (this.receivedCount != null) {
      json[r'received_count'] = this.receivedCount;
    } else {
      json[r'received_count'] = null;
    }
    if (this.lastReceivedAt != null) {
      json[r'last_received_at'] = this.lastReceivedAt!.toUtc().toIso8601String();
    } else {
      json[r'last_received_at'] = null;
    }
    if (this.lastReceivedPath != null) {
      json[r'last_received_path'] = this.lastReceivedPath;
    } else {
      json[r'last_received_path'] = null;
    }
    if (this.blockedReason != null) {
      json[r'blocked_reason'] = this.blockedReason;
    } else {
      json[r'blocked_reason'] = null;
    }
      json[r'available_domains'] = this.availableDomains;
    if (this.assignment != null) {
      json[r'assignment'] = this.assignment;
    } else {
      json[r'assignment'] = null;
    }
    if (this.customization != null) {
      json[r'customization'] = this.customization;
    } else {
      json[r'customization'] = null;
    }
    if (this.receivingEnabled != null) {
      json[r'receiving_enabled'] = this.receivingEnabled;
    } else {
      json[r'receiving_enabled'] = null;
    }
    if (this.senderAllowlist != null) {
      json[r'sender_allowlist'] = this.senderAllowlist;
    } else {
      json[r'sender_allowlist'] = null;
    }
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.sendingEnabled != null) {
      json[r'sending_enabled'] = this.sendingEnabled;
    } else {
      json[r'sending_enabled'] = null;
    }
      json[r'aliases'] = this.aliases;
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
        return true;
      }());

      return MailboxEmail(
        address: mapValueOfType<String>(json, r'address'),
        receivedCount: mapValueOfType<int>(json, r'received_count'),
        lastReceivedAt: mapDateTime(json, r'last_received_at', r''),
        lastReceivedPath: mapValueOfType<String>(json, r'last_received_path'),
        blockedReason: mapValueOfType<String>(json, r'blocked_reason'),
        availableDomains: MailboxEmailAvailableDomainsInner.listFromJson(json[r'available_domains']),
        assignment: MailboxEmailAssignment.fromJson(json[r'assignment']),
        customization: MailboxEmailCustomization.fromJson(json[r'customization']),
        receivingEnabled: mapValueOfType<bool>(json, r'receiving_enabled'),
        senderAllowlist: EmailSenderAllowlist.fromJson(json[r'sender_allowlist']),
        username: mapValueOfType<String>(json, r'username'),
        sendingEnabled: mapValueOfType<bool>(json, r'sending_enabled'),
        aliases: MailboxEmailAliasesInner.listFromJson(json[r'aliases']),
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
  };
}


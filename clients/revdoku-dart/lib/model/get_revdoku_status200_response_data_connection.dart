//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetRevdokuStatus200ResponseDataConnection {
  /// Returns a new [GetRevdokuStatus200ResponseDataConnection] instance.
  GetRevdokuStatus200ResponseDataConnection({
    this.apiKeyId,
    this.label,
    this.tokenType,
    this.scope,
    this.expiresAt,
    this.lastUsedAt,
    this.mailboxAccess,
    this.mailboxIds = const [],
    this.deniedMailboxIds = const [],
    this.mailboxPermissions = const {},
    this.permissions = const {},
    this.agent = const {},
    this.transport,
    this.renewal,
  });

  String? apiKeyId;

  String? label;

  String? tokenType;

  String? scope;

  DateTime? expiresAt;

  DateTime? lastUsedAt;

  String? mailboxAccess;

  List<String> mailboxIds;

  List<String> deniedMailboxIds;

  Map<String, String> mailboxPermissions;

  Map<String, bool> permissions;

  Map<String, Object?>? agent;

  String? transport;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  GetRevdokuStatus200ResponseDataConnectionRenewal? renewal;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetRevdokuStatus200ResponseDataConnection &&
    other.apiKeyId == apiKeyId &&
    other.label == label &&
    other.tokenType == tokenType &&
    other.scope == scope &&
    other.expiresAt == expiresAt &&
    other.lastUsedAt == lastUsedAt &&
    other.mailboxAccess == mailboxAccess &&
    _deepEquality.equals(other.mailboxIds, mailboxIds) &&
    _deepEquality.equals(other.deniedMailboxIds, deniedMailboxIds) &&
    _deepEquality.equals(other.mailboxPermissions, mailboxPermissions) &&
    _deepEquality.equals(other.permissions, permissions) &&
    _deepEquality.equals(other.agent, agent) &&
    other.transport == transport &&
    other.renewal == renewal;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (apiKeyId == null ? 0 : apiKeyId!.hashCode) +
    (label == null ? 0 : label!.hashCode) +
    (tokenType == null ? 0 : tokenType!.hashCode) +
    (scope == null ? 0 : scope!.hashCode) +
    (expiresAt == null ? 0 : expiresAt!.hashCode) +
    (lastUsedAt == null ? 0 : lastUsedAt!.hashCode) +
    (mailboxAccess == null ? 0 : mailboxAccess!.hashCode) +
    (mailboxIds.hashCode) +
    (deniedMailboxIds.hashCode) +
    (mailboxPermissions.hashCode) +
    (permissions.hashCode) +
    (agent == null ? 0 : agent!.hashCode) +
    (transport == null ? 0 : transport!.hashCode) +
    (renewal == null ? 0 : renewal!.hashCode);

  @override
  String toString() => 'GetRevdokuStatus200ResponseDataConnection[apiKeyId=$apiKeyId, label=$label, tokenType=$tokenType, scope=$scope, expiresAt=$expiresAt, lastUsedAt=$lastUsedAt, mailboxAccess=$mailboxAccess, mailboxIds=$mailboxIds, deniedMailboxIds=$deniedMailboxIds, mailboxPermissions=$mailboxPermissions, permissions=$permissions, agent=$agent, transport=$transport, renewal=$renewal]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.apiKeyId != null) {
      json[r'api_key_id'] = this.apiKeyId;
    } else {
      json[r'api_key_id'] = null;
    }
    if (this.label != null) {
      json[r'label'] = this.label;
    } else {
      json[r'label'] = null;
    }
    if (this.tokenType != null) {
      json[r'token_type'] = this.tokenType;
    } else {
      json[r'token_type'] = null;
    }
    if (this.scope != null) {
      json[r'scope'] = this.scope;
    } else {
      json[r'scope'] = null;
    }
    if (this.expiresAt != null) {
      json[r'expires_at'] = this.expiresAt!.toUtc().toIso8601String();
    } else {
      json[r'expires_at'] = null;
    }
    if (this.lastUsedAt != null) {
      json[r'last_used_at'] = this.lastUsedAt!.toUtc().toIso8601String();
    } else {
      json[r'last_used_at'] = null;
    }
    if (this.mailboxAccess != null) {
      json[r'mailbox_access'] = this.mailboxAccess;
    } else {
      json[r'mailbox_access'] = null;
    }
      json[r'mailbox_ids'] = this.mailboxIds;
      json[r'denied_mailbox_ids'] = this.deniedMailboxIds;
      json[r'mailbox_permissions'] = this.mailboxPermissions;
      json[r'permissions'] = this.permissions;
    if (this.agent != null) {
      json[r'agent'] = this.agent;
    } else {
      json[r'agent'] = null;
    }
    if (this.transport != null) {
      json[r'transport'] = this.transport;
    } else {
      json[r'transport'] = null;
    }
    if (this.renewal != null) {
      json[r'renewal'] = this.renewal;
    }
    return json;
  }

  /// Returns a new [GetRevdokuStatus200ResponseDataConnection] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetRevdokuStatus200ResponseDataConnection? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return GetRevdokuStatus200ResponseDataConnection(
        apiKeyId: mapValueOfType<String>(json, r'api_key_id'),
        label: mapValueOfType<String>(json, r'label'),
        tokenType: mapValueOfType<String>(json, r'token_type'),
        scope: mapValueOfType<String>(json, r'scope'),
        expiresAt: mapDateTime(json, r'expires_at', r''),
        lastUsedAt: mapDateTime(json, r'last_used_at', r''),
        mailboxAccess: mapValueOfType<String>(json, r'mailbox_access'),
        mailboxIds: json[r'mailbox_ids'] is Iterable
            ? (json[r'mailbox_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        deniedMailboxIds: json[r'denied_mailbox_ids'] is Iterable
            ? (json[r'denied_mailbox_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        mailboxPermissions: mapCastOfType<String, String>(json, r'mailbox_permissions') ?? const {},
        permissions: mapCastOfType<String, bool>(json, r'permissions') ?? const {},
        agent: mapCastOfType<String, Object?>(json, r'agent') ?? const {},
        transport: mapValueOfType<String>(json, r'transport'),
        renewal: GetRevdokuStatus200ResponseDataConnectionRenewal.fromJson(json[r'renewal']),
      );
    }
    return null;
  }

  static List<GetRevdokuStatus200ResponseDataConnection> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetRevdokuStatus200ResponseDataConnection>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetRevdokuStatus200ResponseDataConnection.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetRevdokuStatus200ResponseDataConnection> mapFromJson(dynamic json) {
    final map = <String, GetRevdokuStatus200ResponseDataConnection>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetRevdokuStatus200ResponseDataConnection.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetRevdokuStatus200ResponseDataConnection-objects as value to a dart map
  static Map<String, List<GetRevdokuStatus200ResponseDataConnection>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetRevdokuStatus200ResponseDataConnection>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetRevdokuStatus200ResponseDataConnection.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


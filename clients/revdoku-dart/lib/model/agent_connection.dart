//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AgentConnection {
  /// Returns a new [AgentConnection] instance.
  AgentConnection({
    required this.apiKey,
    required this.accountId,
    this.accountName,
    required this.scope,
    this.mailboxAccess,
    this.mailboxIds = const [],
    this.mailboxPermissions = const {},
    this.accountConnectionLimits = const {},
    this.expiresAt,
    this.manageAccess = const {},
    this.mailboxes = const [],
    this.guidance,
  });

  String apiKey;

  String accountId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountName;

  AgentConnectionScopeEnum scope;

  AgentConnectionMailboxAccessEnum? mailboxAccess;

  List<String> mailboxIds;

  Map<String, String> mailboxPermissions;

  Map<String, Object?> accountConnectionLimits;

  DateTime? expiresAt;

  Map<String, Object?> manageAccess;

  List<Map<String, Object?>> mailboxes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? guidance;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AgentConnection &&
    other.apiKey == apiKey &&
    other.accountId == accountId &&
    other.accountName == accountName &&
    other.scope == scope &&
    other.mailboxAccess == mailboxAccess &&
    _deepEquality.equals(other.mailboxIds, mailboxIds) &&
    _deepEquality.equals(other.mailboxPermissions, mailboxPermissions) &&
    _deepEquality.equals(other.accountConnectionLimits, accountConnectionLimits) &&
    other.expiresAt == expiresAt &&
    _deepEquality.equals(other.manageAccess, manageAccess) &&
    _deepEquality.equals(other.mailboxes, mailboxes) &&
    other.guidance == guidance;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (apiKey.hashCode) +
    (accountId.hashCode) +
    (accountName == null ? 0 : accountName!.hashCode) +
    (scope.hashCode) +
    (mailboxAccess == null ? 0 : mailboxAccess!.hashCode) +
    (mailboxIds.hashCode) +
    (mailboxPermissions.hashCode) +
    (accountConnectionLimits.hashCode) +
    (expiresAt == null ? 0 : expiresAt!.hashCode) +
    (manageAccess.hashCode) +
    (mailboxes.hashCode) +
    (guidance == null ? 0 : guidance!.hashCode);

  @override
  String toString() => 'AgentConnection[apiKey=$apiKey, accountId=$accountId, accountName=$accountName, scope=$scope, mailboxAccess=$mailboxAccess, mailboxIds=$mailboxIds, mailboxPermissions=$mailboxPermissions, accountConnectionLimits=$accountConnectionLimits, expiresAt=$expiresAt, manageAccess=$manageAccess, mailboxes=$mailboxes, guidance=$guidance]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'api_key'] = this.apiKey;
      json[r'account_id'] = this.accountId;
    if (this.accountName != null) {
      json[r'account_name'] = this.accountName;
    }
      json[r'scope'] = this.scope;
    if (this.mailboxAccess != null) {
      json[r'mailbox_access'] = this.mailboxAccess;
    }
      json[r'mailbox_ids'] = this.mailboxIds;
      json[r'mailbox_permissions'] = this.mailboxPermissions;
      json[r'account_connection_limits'] = this.accountConnectionLimits;
    if (this.expiresAt != null) {
      json[r'expires_at'] = this.expiresAt!.toUtc().toIso8601String();
    } else {
      json[r'expires_at'] = null;
    }
      json[r'manage_access'] = this.manageAccess;
      json[r'mailboxes'] = this.mailboxes;
    if (this.guidance != null) {
      json[r'guidance'] = this.guidance;
    }
    return json;
  }

  /// Returns a new [AgentConnection] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AgentConnection? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'api_key'), 'Required key "AgentConnection[api_key]" is missing from JSON.');
        assert(json[r'api_key'] != null, 'Required key "AgentConnection[api_key]" has a null value in JSON.');
        assert(json.containsKey(r'account_id'), 'Required key "AgentConnection[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "AgentConnection[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'scope'), 'Required key "AgentConnection[scope]" is missing from JSON.');
        assert(json[r'scope'] != null, 'Required key "AgentConnection[scope]" has a null value in JSON.');
        return true;
      }());

      return AgentConnection(
        apiKey: mapValueOfType<String>(json, r'api_key')!,
        accountId: mapValueOfType<String>(json, r'account_id')!,
        accountName: mapValueOfType<String>(json, r'account_name'),
        scope: AgentConnectionScopeEnum.fromJson(json[r'scope'])!,
        mailboxAccess: AgentConnectionMailboxAccessEnum.fromJson(json[r'mailbox_access']),
        mailboxIds: json[r'mailbox_ids'] is Iterable
            ? (json[r'mailbox_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        mailboxPermissions: mapCastOfType<String, String>(json, r'mailbox_permissions') ?? const {},
        accountConnectionLimits: mapCastOfType<String, Object?>(json, r'account_connection_limits') ?? const {},
        expiresAt: mapDateTime(json, r'expires_at', r''),
        manageAccess: mapCastOfType<String, Object?>(json, r'manage_access') ?? const {},
        mailboxes: Map.listFromJson(json[r'mailboxes']),
        guidance: mapValueOfType<String>(json, r'guidance'),
      );
    }
    return null;
  }

  static List<AgentConnection> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgentConnection>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgentConnection.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AgentConnection> mapFromJson(dynamic json) {
    final map = <String, AgentConnection>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AgentConnection.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AgentConnection-objects as value to a dart map
  static Map<String, List<AgentConnection>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AgentConnection>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AgentConnection.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'api_key',
    'account_id',
    'scope',
  };
}


enum AgentConnectionScopeEnum {
  mailboxRead._(r'mailbox_read'),
  mailboxWrite._(r'mailbox_write'),
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const AgentConnectionScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AgentConnectionScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AgentConnectionScopeEnum? fromJson(dynamic value) => AgentConnectionScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AgentConnectionScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AgentConnectionScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgentConnectionScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgentConnectionScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AgentConnectionScopeEnum] to String,
/// and [decode] dynamic data back to [AgentConnectionScopeEnum].
class AgentConnectionScopeEnumTypeTransformer {
  factory AgentConnectionScopeEnumTypeTransformer() => _instance ??= const AgentConnectionScopeEnumTypeTransformer._();

  const AgentConnectionScopeEnumTypeTransformer._();

  String encode(AgentConnectionScopeEnum data) => data._value;

  /// Returns the instance of [AgentConnectionScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AgentConnectionScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AgentConnectionScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_read': return AgentConnectionScopeEnum.mailboxRead;
        case r'mailbox_write': return AgentConnectionScopeEnum.mailboxWrite;
        case r'mailbox_admin': return AgentConnectionScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AgentConnectionScopeEnumTypeTransformer? _instance;
}



enum AgentConnectionMailboxAccessEnum {
  all._(r'all'),
  selected._(r'selected'),
  ;

  /// Instantiate a new enum with the provided value.
  const AgentConnectionMailboxAccessEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AgentConnectionMailboxAccessEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AgentConnectionMailboxAccessEnum? fromJson(dynamic value) => AgentConnectionMailboxAccessEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AgentConnectionMailboxAccessEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AgentConnectionMailboxAccessEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgentConnectionMailboxAccessEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgentConnectionMailboxAccessEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AgentConnectionMailboxAccessEnum] to String,
/// and [decode] dynamic data back to [AgentConnectionMailboxAccessEnum].
class AgentConnectionMailboxAccessEnumTypeTransformer {
  factory AgentConnectionMailboxAccessEnumTypeTransformer() => _instance ??= const AgentConnectionMailboxAccessEnumTypeTransformer._();

  const AgentConnectionMailboxAccessEnumTypeTransformer._();

  String encode(AgentConnectionMailboxAccessEnum data) => data._value;

  /// Returns the instance of [AgentConnectionMailboxAccessEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AgentConnectionMailboxAccessEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AgentConnectionMailboxAccessEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'all': return AgentConnectionMailboxAccessEnum.all;
        case r'selected': return AgentConnectionMailboxAccessEnum.selected;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AgentConnectionMailboxAccessEnumTypeTransformer? _instance;
}



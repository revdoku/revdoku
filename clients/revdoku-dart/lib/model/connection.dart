//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class Connection {
  /// Returns a new [Connection] instance.
  Connection({
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
    this.permissions,
    this.agent = const {},
    this.transport,
    this.renewal,
  });

  String? apiKeyId;

  String? label;

  ConnectionTokenTypeEnum? tokenType;

  ConnectionScopeEnum? scope;

  DateTime? expiresAt;

  DateTime? lastUsedAt;

  ConnectionMailboxAccessEnum? mailboxAccess;

  List<String> mailboxIds;

  List<String> deniedMailboxIds;

  Map<String, String> mailboxPermissions;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ConnectionPermissions? permissions;

  Map<String, Object?>? agent;

  String? transport;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ConnectionRenewal? renewal;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Connection &&
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
    other.permissions == permissions &&
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
    (permissions == null ? 0 : permissions!.hashCode) +
    (agent == null ? 0 : agent!.hashCode) +
    (transport == null ? 0 : transport!.hashCode) +
    (renewal == null ? 0 : renewal!.hashCode);

  @override
  String toString() => 'Connection[apiKeyId=$apiKeyId, label=$label, tokenType=$tokenType, scope=$scope, expiresAt=$expiresAt, lastUsedAt=$lastUsedAt, mailboxAccess=$mailboxAccess, mailboxIds=$mailboxIds, deniedMailboxIds=$deniedMailboxIds, mailboxPermissions=$mailboxPermissions, permissions=$permissions, agent=$agent, transport=$transport, renewal=$renewal]';

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
    if (this.permissions != null) {
      json[r'permissions'] = this.permissions;
    }
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

  /// Returns a new [Connection] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Connection? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return Connection(
        apiKeyId: mapValueOfType<String>(json, r'api_key_id'),
        label: mapValueOfType<String>(json, r'label'),
        tokenType: ConnectionTokenTypeEnum.fromJson(json[r'token_type']),
        scope: ConnectionScopeEnum.fromJson(json[r'scope']),
        expiresAt: mapDateTime(json, r'expires_at', r''),
        lastUsedAt: mapDateTime(json, r'last_used_at', r''),
        mailboxAccess: ConnectionMailboxAccessEnum.fromJson(json[r'mailbox_access']),
        mailboxIds: json[r'mailbox_ids'] is Iterable
            ? (json[r'mailbox_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        deniedMailboxIds: json[r'denied_mailbox_ids'] is Iterable
            ? (json[r'denied_mailbox_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        mailboxPermissions: mapCastOfType<String, String>(json, r'mailbox_permissions') ?? const {},
        permissions: ConnectionPermissions.fromJson(json[r'permissions']),
        agent: mapCastOfType<String, Object?>(json, r'agent') ?? const {},
        transport: mapValueOfType<String>(json, r'transport'),
        renewal: ConnectionRenewal.fromJson(json[r'renewal']),
      );
    }
    return null;
  }

  static List<Connection> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Connection>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Connection.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Connection> mapFromJson(dynamic json) {
    final map = <String, Connection>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Connection.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Connection-objects as value to a dart map
  static Map<String, List<Connection>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Connection>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Connection.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum ConnectionTokenTypeEnum {
  api._(r'api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ConnectionTokenTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ConnectionTokenTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ConnectionTokenTypeEnum? fromJson(dynamic value) => ConnectionTokenTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ConnectionTokenTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ConnectionTokenTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConnectionTokenTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConnectionTokenTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConnectionTokenTypeEnum] to String,
/// and [decode] dynamic data back to [ConnectionTokenTypeEnum].
class ConnectionTokenTypeEnumTypeTransformer {
  factory ConnectionTokenTypeEnumTypeTransformer() => _instance ??= const ConnectionTokenTypeEnumTypeTransformer._();

  const ConnectionTokenTypeEnumTypeTransformer._();

  String encode(ConnectionTokenTypeEnum data) => data._value;

  /// Returns the instance of [ConnectionTokenTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConnectionTokenTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ConnectionTokenTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'api': return ConnectionTokenTypeEnum.api;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ConnectionTokenTypeEnumTypeTransformer? _instance;
}



enum ConnectionScopeEnum {
  mailboxRead._(r'mailbox_read'),
  mailboxWrite._(r'mailbox_write'),
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const ConnectionScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ConnectionScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ConnectionScopeEnum? fromJson(dynamic value) => ConnectionScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ConnectionScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ConnectionScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConnectionScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConnectionScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConnectionScopeEnum] to String,
/// and [decode] dynamic data back to [ConnectionScopeEnum].
class ConnectionScopeEnumTypeTransformer {
  factory ConnectionScopeEnumTypeTransformer() => _instance ??= const ConnectionScopeEnumTypeTransformer._();

  const ConnectionScopeEnumTypeTransformer._();

  String encode(ConnectionScopeEnum data) => data._value;

  /// Returns the instance of [ConnectionScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConnectionScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ConnectionScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_read': return ConnectionScopeEnum.mailboxRead;
        case r'mailbox_write': return ConnectionScopeEnum.mailboxWrite;
        case r'mailbox_admin': return ConnectionScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ConnectionScopeEnumTypeTransformer? _instance;
}



enum ConnectionMailboxAccessEnum {
  all._(r'all'),
  selected._(r'selected'),
  ;

  /// Instantiate a new enum with the provided value.
  const ConnectionMailboxAccessEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ConnectionMailboxAccessEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ConnectionMailboxAccessEnum? fromJson(dynamic value) => ConnectionMailboxAccessEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ConnectionMailboxAccessEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ConnectionMailboxAccessEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConnectionMailboxAccessEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConnectionMailboxAccessEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConnectionMailboxAccessEnum] to String,
/// and [decode] dynamic data back to [ConnectionMailboxAccessEnum].
class ConnectionMailboxAccessEnumTypeTransformer {
  factory ConnectionMailboxAccessEnumTypeTransformer() => _instance ??= const ConnectionMailboxAccessEnumTypeTransformer._();

  const ConnectionMailboxAccessEnumTypeTransformer._();

  String encode(ConnectionMailboxAccessEnum data) => data._value;

  /// Returns the instance of [ConnectionMailboxAccessEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConnectionMailboxAccessEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ConnectionMailboxAccessEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'all': return ConnectionMailboxAccessEnum.all;
        case r'selected': return ConnectionMailboxAccessEnum.selected;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ConnectionMailboxAccessEnumTypeTransformer? _instance;
}



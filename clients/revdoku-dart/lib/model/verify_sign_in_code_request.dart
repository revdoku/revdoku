//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class VerifySignInCodeRequest {
  /// Returns a new [VerifySignInCodeRequest] instance.
  VerifySignInCodeRequest({
    required this.email,
    required this.code,
    this.label,
    this.permissionScope = const VerifySignInCodeRequestPermissionScopeEnum._('mailbox_admin'),
    this.mailboxAccess = const VerifySignInCodeRequestMailboxAccessEnum._('all'),
    this.mailboxIds = const [],
    this.mailboxPermissions = const {},
    this.accountId,
    this.reason,
  });

  String email;

  /// Six digits; spaces are ignored.
  String code;

  /// Connection name shown in Account access.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? label;

  VerifySignInCodeRequestPermissionScopeEnum permissionScope;

  VerifySignInCodeRequestMailboxAccessEnum mailboxAccess;

  /// Required when mailbox_access is selected.
  List<String> mailboxIds;

  /// Optional access per selected mailbox ID: read or write. Without an entry, a mailbox gets write, or read when permission_scope is mailbox_read.
  Map<String, VerifySignInCodeRequestMailboxPermissionsEnum> mailboxPermissions;

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
  bool operator ==(Object other) => identical(this, other) || other is VerifySignInCodeRequest &&
    other.email == email &&
    other.code == code &&
    other.label == label &&
    other.permissionScope == permissionScope &&
    other.mailboxAccess == mailboxAccess &&
    _deepEquality.equals(other.mailboxIds, mailboxIds) &&
    _deepEquality.equals(other.mailboxPermissions, mailboxPermissions) &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (code.hashCode) +
    (label == null ? 0 : label!.hashCode) +
    (permissionScope.hashCode) +
    (mailboxAccess.hashCode) +
    (mailboxIds.hashCode) +
    (mailboxPermissions.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'VerifySignInCodeRequest[email=$email, code=$code, label=$label, permissionScope=$permissionScope, mailboxAccess=$mailboxAccess, mailboxIds=$mailboxIds, mailboxPermissions=$mailboxPermissions, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'code'] = this.code;
    if (this.label != null) {
      json[r'label'] = this.label;
    }
      json[r'permission_scope'] = this.permissionScope;
      json[r'mailbox_access'] = this.mailboxAccess;
      json[r'mailbox_ids'] = this.mailboxIds;
      json[r'mailbox_permissions'] = this.mailboxPermissions;
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

  /// Returns a new [VerifySignInCodeRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifySignInCodeRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'email'), 'Required key "VerifySignInCodeRequest[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "VerifySignInCodeRequest[email]" has a null value in JSON.');
        assert(json.containsKey(r'code'), 'Required key "VerifySignInCodeRequest[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "VerifySignInCodeRequest[code]" has a null value in JSON.');
        return true;
      }());

      return VerifySignInCodeRequest(
        email: mapValueOfType<String>(json, r'email')!,
        code: mapValueOfType<String>(json, r'code')!,
        label: mapValueOfType<String>(json, r'label'),
        permissionScope: VerifySignInCodeRequestPermissionScopeEnum.fromJson(json[r'permission_scope']) ?? const VerifySignInCodeRequestPermissionScopeEnum._('mailbox_admin'),
        mailboxAccess: VerifySignInCodeRequestMailboxAccessEnum.fromJson(json[r'mailbox_access']) ?? const VerifySignInCodeRequestMailboxAccessEnum._('all'),
        mailboxIds: json[r'mailbox_ids'] is Iterable
            ? (json[r'mailbox_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        mailboxPermissions: mapCastOfType<String, String>(json, r'mailbox_permissions') ?? const {},
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<VerifySignInCodeRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifySignInCodeRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifySignInCodeRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifySignInCodeRequest> mapFromJson(dynamic json) {
    final map = <String, VerifySignInCodeRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifySignInCodeRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifySignInCodeRequest-objects as value to a dart map
  static Map<String, List<VerifySignInCodeRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifySignInCodeRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifySignInCodeRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'code',
  };
}


enum VerifySignInCodeRequestPermissionScopeEnum {
  mailboxRead._(r'mailbox_read'),
  mailboxWrite._(r'mailbox_write'),
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const VerifySignInCodeRequestPermissionScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VerifySignInCodeRequestPermissionScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VerifySignInCodeRequestPermissionScopeEnum? fromJson(dynamic value) => VerifySignInCodeRequestPermissionScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VerifySignInCodeRequestPermissionScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VerifySignInCodeRequestPermissionScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifySignInCodeRequestPermissionScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifySignInCodeRequestPermissionScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerifySignInCodeRequestPermissionScopeEnum] to String,
/// and [decode] dynamic data back to [VerifySignInCodeRequestPermissionScopeEnum].
class VerifySignInCodeRequestPermissionScopeEnumTypeTransformer {
  factory VerifySignInCodeRequestPermissionScopeEnumTypeTransformer() => _instance ??= const VerifySignInCodeRequestPermissionScopeEnumTypeTransformer._();

  const VerifySignInCodeRequestPermissionScopeEnumTypeTransformer._();

  String encode(VerifySignInCodeRequestPermissionScopeEnum data) => data._value;

  /// Returns the instance of [VerifySignInCodeRequestPermissionScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerifySignInCodeRequestPermissionScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is VerifySignInCodeRequestPermissionScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_read': return VerifySignInCodeRequestPermissionScopeEnum.mailboxRead;
        case r'mailbox_write': return VerifySignInCodeRequestPermissionScopeEnum.mailboxWrite;
        case r'mailbox_admin': return VerifySignInCodeRequestPermissionScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VerifySignInCodeRequestPermissionScopeEnumTypeTransformer? _instance;
}



enum VerifySignInCodeRequestMailboxAccessEnum {
  all._(r'all'),
  selected._(r'selected'),
  ;

  /// Instantiate a new enum with the provided value.
  const VerifySignInCodeRequestMailboxAccessEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VerifySignInCodeRequestMailboxAccessEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VerifySignInCodeRequestMailboxAccessEnum? fromJson(dynamic value) => VerifySignInCodeRequestMailboxAccessEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VerifySignInCodeRequestMailboxAccessEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VerifySignInCodeRequestMailboxAccessEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifySignInCodeRequestMailboxAccessEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifySignInCodeRequestMailboxAccessEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerifySignInCodeRequestMailboxAccessEnum] to String,
/// and [decode] dynamic data back to [VerifySignInCodeRequestMailboxAccessEnum].
class VerifySignInCodeRequestMailboxAccessEnumTypeTransformer {
  factory VerifySignInCodeRequestMailboxAccessEnumTypeTransformer() => _instance ??= const VerifySignInCodeRequestMailboxAccessEnumTypeTransformer._();

  const VerifySignInCodeRequestMailboxAccessEnumTypeTransformer._();

  String encode(VerifySignInCodeRequestMailboxAccessEnum data) => data._value;

  /// Returns the instance of [VerifySignInCodeRequestMailboxAccessEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerifySignInCodeRequestMailboxAccessEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is VerifySignInCodeRequestMailboxAccessEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'all': return VerifySignInCodeRequestMailboxAccessEnum.all;
        case r'selected': return VerifySignInCodeRequestMailboxAccessEnum.selected;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VerifySignInCodeRequestMailboxAccessEnumTypeTransformer? _instance;
}



enum VerifySignInCodeRequestMailboxPermissionsEnum {
  read._(r'read'),
  write._(r'write'),
  ;

  /// Instantiate a new enum with the provided value.
  const VerifySignInCodeRequestMailboxPermissionsEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VerifySignInCodeRequestMailboxPermissionsEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VerifySignInCodeRequestMailboxPermissionsEnum? fromJson(dynamic value) => VerifySignInCodeRequestMailboxPermissionsEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VerifySignInCodeRequestMailboxPermissionsEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VerifySignInCodeRequestMailboxPermissionsEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifySignInCodeRequestMailboxPermissionsEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifySignInCodeRequestMailboxPermissionsEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerifySignInCodeRequestMailboxPermissionsEnum] to String,
/// and [decode] dynamic data back to [VerifySignInCodeRequestMailboxPermissionsEnum].
class VerifySignInCodeRequestMailboxPermissionsEnumTypeTransformer {
  factory VerifySignInCodeRequestMailboxPermissionsEnumTypeTransformer() => _instance ??= const VerifySignInCodeRequestMailboxPermissionsEnumTypeTransformer._();

  const VerifySignInCodeRequestMailboxPermissionsEnumTypeTransformer._();

  String encode(VerifySignInCodeRequestMailboxPermissionsEnum data) => data._value;

  /// Returns the instance of [VerifySignInCodeRequestMailboxPermissionsEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerifySignInCodeRequestMailboxPermissionsEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is VerifySignInCodeRequestMailboxPermissionsEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'read': return VerifySignInCodeRequestMailboxPermissionsEnum.read;
        case r'write': return VerifySignInCodeRequestMailboxPermissionsEnum.write;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VerifySignInCodeRequestMailboxPermissionsEnumTypeTransformer? _instance;
}



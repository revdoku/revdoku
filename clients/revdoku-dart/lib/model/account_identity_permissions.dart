//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AccountIdentityPermissions {
  /// Returns a new [AccountIdentityPermissions] instance.
  AccountIdentityPermissions({
    this.scope,
    this.mailboxAccess,
    this.canCreateMailboxes,
  });

  AccountIdentityPermissionsScopeEnum? scope;

  AccountIdentityPermissionsMailboxAccessEnum? mailboxAccess;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? canCreateMailboxes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountIdentityPermissions &&
    other.scope == scope &&
    other.mailboxAccess == mailboxAccess &&
    other.canCreateMailboxes == canCreateMailboxes;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (scope == null ? 0 : scope!.hashCode) +
    (mailboxAccess == null ? 0 : mailboxAccess!.hashCode) +
    (canCreateMailboxes == null ? 0 : canCreateMailboxes!.hashCode);

  @override
  String toString() => 'AccountIdentityPermissions[scope=$scope, mailboxAccess=$mailboxAccess, canCreateMailboxes=$canCreateMailboxes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.scope != null) {
      json[r'scope'] = this.scope;
    }
    if (this.mailboxAccess != null) {
      json[r'mailbox_access'] = this.mailboxAccess;
    }
    if (this.canCreateMailboxes != null) {
      json[r'can_create_mailboxes'] = this.canCreateMailboxes;
    }
    return json;
  }

  /// Returns a new [AccountIdentityPermissions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountIdentityPermissions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return AccountIdentityPermissions(
        scope: AccountIdentityPermissionsScopeEnum.fromJson(json[r'scope']),
        mailboxAccess: AccountIdentityPermissionsMailboxAccessEnum.fromJson(json[r'mailbox_access']),
        canCreateMailboxes: mapValueOfType<bool>(json, r'can_create_mailboxes'),
      );
    }
    return null;
  }

  static List<AccountIdentityPermissions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountIdentityPermissions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountIdentityPermissions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountIdentityPermissions> mapFromJson(dynamic json) {
    final map = <String, AccountIdentityPermissions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountIdentityPermissions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountIdentityPermissions-objects as value to a dart map
  static Map<String, List<AccountIdentityPermissions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountIdentityPermissions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountIdentityPermissions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum AccountIdentityPermissionsScopeEnum {
  mailboxRead._(r'mailbox_read'),
  mailboxWrite._(r'mailbox_write'),
  mailboxAdmin._(r'mailbox_admin'),
  ;

  /// Instantiate a new enum with the provided value.
  const AccountIdentityPermissionsScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AccountIdentityPermissionsScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AccountIdentityPermissionsScopeEnum? fromJson(dynamic value) => AccountIdentityPermissionsScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AccountIdentityPermissionsScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AccountIdentityPermissionsScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountIdentityPermissionsScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountIdentityPermissionsScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AccountIdentityPermissionsScopeEnum] to String,
/// and [decode] dynamic data back to [AccountIdentityPermissionsScopeEnum].
class AccountIdentityPermissionsScopeEnumTypeTransformer {
  factory AccountIdentityPermissionsScopeEnumTypeTransformer() => _instance ??= const AccountIdentityPermissionsScopeEnumTypeTransformer._();

  const AccountIdentityPermissionsScopeEnumTypeTransformer._();

  String encode(AccountIdentityPermissionsScopeEnum data) => data._value;

  /// Returns the instance of [AccountIdentityPermissionsScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountIdentityPermissionsScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AccountIdentityPermissionsScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_read': return AccountIdentityPermissionsScopeEnum.mailboxRead;
        case r'mailbox_write': return AccountIdentityPermissionsScopeEnum.mailboxWrite;
        case r'mailbox_admin': return AccountIdentityPermissionsScopeEnum.mailboxAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AccountIdentityPermissionsScopeEnumTypeTransformer? _instance;
}



enum AccountIdentityPermissionsMailboxAccessEnum {
  all._(r'all'),
  selected._(r'selected'),
  ;

  /// Instantiate a new enum with the provided value.
  const AccountIdentityPermissionsMailboxAccessEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AccountIdentityPermissionsMailboxAccessEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AccountIdentityPermissionsMailboxAccessEnum? fromJson(dynamic value) => AccountIdentityPermissionsMailboxAccessEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AccountIdentityPermissionsMailboxAccessEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AccountIdentityPermissionsMailboxAccessEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountIdentityPermissionsMailboxAccessEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountIdentityPermissionsMailboxAccessEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AccountIdentityPermissionsMailboxAccessEnum] to String,
/// and [decode] dynamic data back to [AccountIdentityPermissionsMailboxAccessEnum].
class AccountIdentityPermissionsMailboxAccessEnumTypeTransformer {
  factory AccountIdentityPermissionsMailboxAccessEnumTypeTransformer() => _instance ??= const AccountIdentityPermissionsMailboxAccessEnumTypeTransformer._();

  const AccountIdentityPermissionsMailboxAccessEnumTypeTransformer._();

  String encode(AccountIdentityPermissionsMailboxAccessEnum data) => data._value;

  /// Returns the instance of [AccountIdentityPermissionsMailboxAccessEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountIdentityPermissionsMailboxAccessEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AccountIdentityPermissionsMailboxAccessEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'all': return AccountIdentityPermissionsMailboxAccessEnum.all;
        case r'selected': return AccountIdentityPermissionsMailboxAccessEnum.selected;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AccountIdentityPermissionsMailboxAccessEnumTypeTransformer? _instance;
}



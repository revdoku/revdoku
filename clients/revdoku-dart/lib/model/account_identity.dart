//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AccountIdentity {
  /// Returns a new [AccountIdentity] instance.
  AccountIdentity({
    required this.id,
    required this.name,
    required this.accountKind,
    required this.clientName,
    required this.agencyAccount,
    this.region,
    this.status,
    this.permissions,
  });

  String id;

  /// Account name, separate from the client person or business.
  String name;

  AccountIdentityAccountKindEnum accountKind;

  /// Client person or business name, or null when unset.
  String? clientName;

  AccountIdentityAgencyAccount? agencyAccount;

  String? region;

  AccountIdentityStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountIdentityPermissions? permissions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountIdentity &&
    other.id == id &&
    other.name == name &&
    other.accountKind == accountKind &&
    other.clientName == clientName &&
    other.agencyAccount == agencyAccount &&
    other.region == region &&
    other.status == status &&
    other.permissions == permissions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (accountKind.hashCode) +
    (clientName == null ? 0 : clientName!.hashCode) +
    (agencyAccount == null ? 0 : agencyAccount!.hashCode) +
    (region == null ? 0 : region!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (permissions == null ? 0 : permissions!.hashCode);

  @override
  String toString() => 'AccountIdentity[id=$id, name=$name, accountKind=$accountKind, clientName=$clientName, agencyAccount=$agencyAccount, region=$region, status=$status, permissions=$permissions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'account_kind'] = this.accountKind;
    if (this.clientName != null) {
      json[r'client_name'] = this.clientName;
    } else {
      json[r'client_name'] = null;
    }
    if (this.agencyAccount != null) {
      json[r'agency_account'] = this.agencyAccount;
    } else {
      json[r'agency_account'] = null;
    }
    if (this.region != null) {
      json[r'region'] = this.region;
    } else {
      json[r'region'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.permissions != null) {
      json[r'permissions'] = this.permissions;
    } else {
      json[r'permissions'] = null;
    }
    return json;
  }

  /// Returns a new [AccountIdentity] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountIdentity? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "AccountIdentity[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "AccountIdentity[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "AccountIdentity[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "AccountIdentity[name]" has a null value in JSON.');
        assert(json.containsKey(r'account_kind'), 'Required key "AccountIdentity[account_kind]" is missing from JSON.');
        assert(json[r'account_kind'] != null, 'Required key "AccountIdentity[account_kind]" has a null value in JSON.');
        assert(json.containsKey(r'client_name'), 'Required key "AccountIdentity[client_name]" is missing from JSON.');
        assert(json.containsKey(r'agency_account'), 'Required key "AccountIdentity[agency_account]" is missing from JSON.');
        return true;
      }());

      return AccountIdentity(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        accountKind: AccountIdentityAccountKindEnum.fromJson(json[r'account_kind'])!,
        clientName: mapValueOfType<String>(json, r'client_name'),
        agencyAccount: AccountIdentityAgencyAccount.fromJson(json[r'agency_account']),
        region: mapValueOfType<String>(json, r'region'),
        status: AccountIdentityStatusEnum.fromJson(json[r'status']),
        permissions: AccountIdentityPermissions.fromJson(json[r'permissions']),
      );
    }
    return null;
  }

  static List<AccountIdentity> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountIdentity>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountIdentity.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountIdentity> mapFromJson(dynamic json) {
    final map = <String, AccountIdentity>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountIdentity.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountIdentity-objects as value to a dart map
  static Map<String, List<AccountIdentity>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountIdentity>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountIdentity.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'account_kind',
    'client_name',
    'agency_account',
  };
}


enum AccountIdentityAccountKindEnum {
  standard._(r'standard'),
  agency._(r'agency'),
  client._(r'client'),
  ;

  /// Instantiate a new enum with the provided value.
  const AccountIdentityAccountKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AccountIdentityAccountKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AccountIdentityAccountKindEnum? fromJson(dynamic value) => AccountIdentityAccountKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AccountIdentityAccountKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AccountIdentityAccountKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountIdentityAccountKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountIdentityAccountKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AccountIdentityAccountKindEnum] to String,
/// and [decode] dynamic data back to [AccountIdentityAccountKindEnum].
class AccountIdentityAccountKindEnumTypeTransformer {
  factory AccountIdentityAccountKindEnumTypeTransformer() => _instance ??= const AccountIdentityAccountKindEnumTypeTransformer._();

  const AccountIdentityAccountKindEnumTypeTransformer._();

  String encode(AccountIdentityAccountKindEnum data) => data._value;

  /// Returns the instance of [AccountIdentityAccountKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountIdentityAccountKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AccountIdentityAccountKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'standard': return AccountIdentityAccountKindEnum.standard;
        case r'agency': return AccountIdentityAccountKindEnum.agency;
        case r'client': return AccountIdentityAccountKindEnum.client;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AccountIdentityAccountKindEnumTypeTransformer? _instance;
}



enum AccountIdentityStatusEnum {
  active._(r'active'),
  readOnly._(r'read_only'),
  ;

  /// Instantiate a new enum with the provided value.
  const AccountIdentityStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AccountIdentityStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AccountIdentityStatusEnum? fromJson(dynamic value) => AccountIdentityStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AccountIdentityStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AccountIdentityStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountIdentityStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountIdentityStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AccountIdentityStatusEnum] to String,
/// and [decode] dynamic data back to [AccountIdentityStatusEnum].
class AccountIdentityStatusEnumTypeTransformer {
  factory AccountIdentityStatusEnumTypeTransformer() => _instance ??= const AccountIdentityStatusEnumTypeTransformer._();

  const AccountIdentityStatusEnumTypeTransformer._();

  String encode(AccountIdentityStatusEnum data) => data._value;

  /// Returns the instance of [AccountIdentityStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountIdentityStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AccountIdentityStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'active': return AccountIdentityStatusEnum.active;
        case r'read_only': return AccountIdentityStatusEnum.readOnly;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AccountIdentityStatusEnumTypeTransformer? _instance;
}



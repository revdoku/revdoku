//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AccountList {
  /// Returns a new [AccountList] instance.
  AccountList({
    this.accounts = const [],
    required this.defaultAccountId,
    required this.pagination,
  });

  List<AccountIdentity> accounts;

  /// Account used when a request does not send account_id.
  String? defaultAccountId;

  Pagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountList &&
    _deepEquality.equals(other.accounts, accounts) &&
    other.defaultAccountId == defaultAccountId &&
    other.pagination == pagination;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accounts.hashCode) +
    (defaultAccountId == null ? 0 : defaultAccountId!.hashCode) +
    (pagination.hashCode);

  @override
  String toString() => 'AccountList[accounts=$accounts, defaultAccountId=$defaultAccountId, pagination=$pagination]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accounts'] = this.accounts;
    if (this.defaultAccountId != null) {
      json[r'default_account_id'] = this.defaultAccountId;
    } else {
      json[r'default_account_id'] = null;
    }
      json[r'pagination'] = this.pagination;
    return json;
  }

  /// Returns a new [AccountList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accounts'), 'Required key "AccountList[accounts]" is missing from JSON.');
        assert(json[r'accounts'] != null, 'Required key "AccountList[accounts]" has a null value in JSON.');
        assert(json.containsKey(r'default_account_id'), 'Required key "AccountList[default_account_id]" is missing from JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "AccountList[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "AccountList[pagination]" has a null value in JSON.');
        return true;
      }());

      return AccountList(
        accounts: AccountIdentity.listFromJson(json[r'accounts']),
        defaultAccountId: mapValueOfType<String>(json, r'default_account_id'),
        pagination: Pagination.fromJson(json[r'pagination'])!,
      );
    }
    return null;
  }

  static List<AccountList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountList> mapFromJson(dynamic json) {
    final map = <String, AccountList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountList-objects as value to a dart map
  static Map<String, List<AccountList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accounts',
    'default_account_id',
    'pagination',
  };
}


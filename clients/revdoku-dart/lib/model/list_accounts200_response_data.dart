//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ListAccounts200ResponseData {
  /// Returns a new [ListAccounts200ResponseData] instance.
  ListAccounts200ResponseData({
    this.accounts = const [],
    required this.defaultAccountId,
    required this.pagination,
  });

  List<AccountIdentity> accounts;

  String? defaultAccountId;

  AccountPagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ListAccounts200ResponseData &&
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
  String toString() => 'ListAccounts200ResponseData[accounts=$accounts, defaultAccountId=$defaultAccountId, pagination=$pagination]';

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

  /// Returns a new [ListAccounts200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ListAccounts200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accounts'), 'Required key "ListAccounts200ResponseData[accounts]" is missing from JSON.');
        assert(json[r'accounts'] != null, 'Required key "ListAccounts200ResponseData[accounts]" has a null value in JSON.');
        assert(json.containsKey(r'default_account_id'), 'Required key "ListAccounts200ResponseData[default_account_id]" is missing from JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "ListAccounts200ResponseData[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "ListAccounts200ResponseData[pagination]" has a null value in JSON.');
        return true;
      }());

      return ListAccounts200ResponseData(
        accounts: AccountIdentity.listFromJson(json[r'accounts']),
        defaultAccountId: mapValueOfType<String>(json, r'default_account_id'),
        pagination: AccountPagination.fromJson(json[r'pagination'])!,
      );
    }
    return null;
  }

  static List<ListAccounts200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ListAccounts200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ListAccounts200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ListAccounts200ResponseData> mapFromJson(dynamic json) {
    final map = <String, ListAccounts200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ListAccounts200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ListAccounts200ResponseData-objects as value to a dart map
  static Map<String, List<ListAccounts200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ListAccounts200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ListAccounts200ResponseData.listFromJson(entry.value, growable: growable,);
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


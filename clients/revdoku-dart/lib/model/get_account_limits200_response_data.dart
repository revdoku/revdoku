//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetAccountLimits200ResponseData {
  /// Returns a new [GetAccountLimits200ResponseData] instance.
  GetAccountLimits200ResponseData({
    required this.accountId,
    required this.limits,
    this.usage,
  });

  String accountId;

  AccountLimits limits;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  GetAccountLimits200ResponseDataUsage? usage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetAccountLimits200ResponseData &&
    other.accountId == accountId &&
    other.limits == limits &&
    other.usage == usage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (limits.hashCode) +
    (usage == null ? 0 : usage!.hashCode);

  @override
  String toString() => 'GetAccountLimits200ResponseData[accountId=$accountId, limits=$limits, usage=$usage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'limits'] = this.limits;
    if (this.usage != null) {
      json[r'usage'] = this.usage;
    }
    return json;
  }

  /// Returns a new [GetAccountLimits200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetAccountLimits200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'account_id'), 'Required key "GetAccountLimits200ResponseData[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "GetAccountLimits200ResponseData[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'limits'), 'Required key "GetAccountLimits200ResponseData[limits]" is missing from JSON.');
        assert(json[r'limits'] != null, 'Required key "GetAccountLimits200ResponseData[limits]" has a null value in JSON.');
        return true;
      }());

      return GetAccountLimits200ResponseData(
        accountId: mapValueOfType<String>(json, r'account_id')!,
        limits: AccountLimits.fromJson(json[r'limits'])!,
        usage: GetAccountLimits200ResponseDataUsage.fromJson(json[r'usage']),
      );
    }
    return null;
  }

  static List<GetAccountLimits200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetAccountLimits200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetAccountLimits200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetAccountLimits200ResponseData> mapFromJson(dynamic json) {
    final map = <String, GetAccountLimits200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetAccountLimits200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetAccountLimits200ResponseData-objects as value to a dart map
  static Map<String, List<GetAccountLimits200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetAccountLimits200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetAccountLimits200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'limits',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetAccountLimits200ResponseDataUsageMailboxCreations {
  /// Returns a new [GetAccountLimits200ResponseDataUsageMailboxCreations] instance.
  GetAccountLimits200ResponseDataUsageMailboxCreations({
    required this.used,
    required this.remaining,
    required this.monthlyLimit,
    required this.resetsAt,
  });

  /// Minimum value: 0
  int used;

  /// Minimum value: 0
  int remaining;

  /// Minimum value: 0
  int monthlyLimit;

  DateTime resetsAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetAccountLimits200ResponseDataUsageMailboxCreations &&
    other.used == used &&
    other.remaining == remaining &&
    other.monthlyLimit == monthlyLimit &&
    other.resetsAt == resetsAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (used.hashCode) +
    (remaining.hashCode) +
    (monthlyLimit.hashCode) +
    (resetsAt.hashCode);

  @override
  String toString() => 'GetAccountLimits200ResponseDataUsageMailboxCreations[used=$used, remaining=$remaining, monthlyLimit=$monthlyLimit, resetsAt=$resetsAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'used'] = this.used;
      json[r'remaining'] = this.remaining;
      json[r'monthly_limit'] = this.monthlyLimit;
      json[r'resets_at'] = this.resetsAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [GetAccountLimits200ResponseDataUsageMailboxCreations] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetAccountLimits200ResponseDataUsageMailboxCreations? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'used'), 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[used]" is missing from JSON.');
        assert(json[r'used'] != null, 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[used]" has a null value in JSON.');
        assert(json.containsKey(r'remaining'), 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[remaining]" is missing from JSON.');
        assert(json[r'remaining'] != null, 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[remaining]" has a null value in JSON.');
        assert(json.containsKey(r'monthly_limit'), 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[monthly_limit]" is missing from JSON.');
        assert(json[r'monthly_limit'] != null, 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[monthly_limit]" has a null value in JSON.');
        assert(json.containsKey(r'resets_at'), 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[resets_at]" is missing from JSON.');
        assert(json[r'resets_at'] != null, 'Required key "GetAccountLimits200ResponseDataUsageMailboxCreations[resets_at]" has a null value in JSON.');
        return true;
      }());

      return GetAccountLimits200ResponseDataUsageMailboxCreations(
        used: mapValueOfType<int>(json, r'used')!,
        remaining: mapValueOfType<int>(json, r'remaining')!,
        monthlyLimit: mapValueOfType<int>(json, r'monthly_limit')!,
        resetsAt: mapDateTime(json, r'resets_at', r'')!,
      );
    }
    return null;
  }

  static List<GetAccountLimits200ResponseDataUsageMailboxCreations> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetAccountLimits200ResponseDataUsageMailboxCreations>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetAccountLimits200ResponseDataUsageMailboxCreations.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetAccountLimits200ResponseDataUsageMailboxCreations> mapFromJson(dynamic json) {
    final map = <String, GetAccountLimits200ResponseDataUsageMailboxCreations>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetAccountLimits200ResponseDataUsageMailboxCreations.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetAccountLimits200ResponseDataUsageMailboxCreations-objects as value to a dart map
  static Map<String, List<GetAccountLimits200ResponseDataUsageMailboxCreations>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetAccountLimits200ResponseDataUsageMailboxCreations>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetAccountLimits200ResponseDataUsageMailboxCreations.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'used',
    'remaining',
    'monthly_limit',
    'resets_at',
  };
}


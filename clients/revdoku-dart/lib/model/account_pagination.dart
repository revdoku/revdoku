//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AccountPagination {
  /// Returns a new [AccountPagination] instance.
  AccountPagination({
    required this.limit,
    required this.offset,
    required this.hasMore,
    required this.nextOffset,
  });

  /// Minimum value: 1
  /// Maximum value: 100
  int limit;

  /// Minimum value: 0
  int offset;

  bool hasMore;

  /// Minimum value: 0
  int? nextOffset;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountPagination &&
    other.limit == limit &&
    other.offset == offset &&
    other.hasMore == hasMore &&
    other.nextOffset == nextOffset;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (limit.hashCode) +
    (offset.hashCode) +
    (hasMore.hashCode) +
    (nextOffset == null ? 0 : nextOffset!.hashCode);

  @override
  String toString() => 'AccountPagination[limit=$limit, offset=$offset, hasMore=$hasMore, nextOffset=$nextOffset]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'limit'] = this.limit;
      json[r'offset'] = this.offset;
      json[r'has_more'] = this.hasMore;
    if (this.nextOffset != null) {
      json[r'next_offset'] = this.nextOffset;
    } else {
      json[r'next_offset'] = null;
    }
    return json;
  }

  /// Returns a new [AccountPagination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountPagination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'limit'), 'Required key "AccountPagination[limit]" is missing from JSON.');
        assert(json[r'limit'] != null, 'Required key "AccountPagination[limit]" has a null value in JSON.');
        assert(json.containsKey(r'offset'), 'Required key "AccountPagination[offset]" is missing from JSON.');
        assert(json[r'offset'] != null, 'Required key "AccountPagination[offset]" has a null value in JSON.');
        assert(json.containsKey(r'has_more'), 'Required key "AccountPagination[has_more]" is missing from JSON.');
        assert(json[r'has_more'] != null, 'Required key "AccountPagination[has_more]" has a null value in JSON.');
        assert(json.containsKey(r'next_offset'), 'Required key "AccountPagination[next_offset]" is missing from JSON.');
        return true;
      }());

      return AccountPagination(
        limit: mapValueOfType<int>(json, r'limit')!,
        offset: mapValueOfType<int>(json, r'offset')!,
        hasMore: mapValueOfType<bool>(json, r'has_more')!,
        nextOffset: mapValueOfType<int>(json, r'next_offset'),
      );
    }
    return null;
  }

  static List<AccountPagination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountPagination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountPagination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountPagination> mapFromJson(dynamic json) {
    final map = <String, AccountPagination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountPagination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountPagination-objects as value to a dart map
  static Map<String, List<AccountPagination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountPagination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountPagination.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'limit',
    'offset',
    'has_more',
    'next_offset',
  };
}


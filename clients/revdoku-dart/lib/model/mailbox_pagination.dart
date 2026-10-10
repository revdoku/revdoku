//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxPagination {
  /// Returns a new [MailboxPagination] instance.
  MailboxPagination({
    required this.limit,
    required this.offset,
    required this.total,
    required this.hasMore,
    required this.nextOffset,
  });

  /// Minimum value: 1
  /// Maximum value: 100
  int limit;

  /// Minimum value: 0
  int offset;

  /// Matching mailboxes for the selected status across all pages.
  ///
  /// Minimum value: 0
  int total;

  bool hasMore;

  /// Minimum value: 0
  int? nextOffset;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxPagination &&
    other.limit == limit &&
    other.offset == offset &&
    other.total == total &&
    other.hasMore == hasMore &&
    other.nextOffset == nextOffset;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (limit.hashCode) +
    (offset.hashCode) +
    (total.hashCode) +
    (hasMore.hashCode) +
    (nextOffset == null ? 0 : nextOffset!.hashCode);

  @override
  String toString() => 'MailboxPagination[limit=$limit, offset=$offset, total=$total, hasMore=$hasMore, nextOffset=$nextOffset]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'limit'] = this.limit;
      json[r'offset'] = this.offset;
      json[r'total'] = this.total;
      json[r'has_more'] = this.hasMore;
    if (this.nextOffset != null) {
      json[r'next_offset'] = this.nextOffset;
    } else {
      json[r'next_offset'] = null;
    }
    return json;
  }

  /// Returns a new [MailboxPagination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxPagination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'limit'), 'Required key "MailboxPagination[limit]" is missing from JSON.');
        assert(json[r'limit'] != null, 'Required key "MailboxPagination[limit]" has a null value in JSON.');
        assert(json.containsKey(r'offset'), 'Required key "MailboxPagination[offset]" is missing from JSON.');
        assert(json[r'offset'] != null, 'Required key "MailboxPagination[offset]" has a null value in JSON.');
        assert(json.containsKey(r'total'), 'Required key "MailboxPagination[total]" is missing from JSON.');
        assert(json[r'total'] != null, 'Required key "MailboxPagination[total]" has a null value in JSON.');
        assert(json.containsKey(r'has_more'), 'Required key "MailboxPagination[has_more]" is missing from JSON.');
        assert(json[r'has_more'] != null, 'Required key "MailboxPagination[has_more]" has a null value in JSON.');
        assert(json.containsKey(r'next_offset'), 'Required key "MailboxPagination[next_offset]" is missing from JSON.');
        return true;
      }());

      return MailboxPagination(
        limit: mapValueOfType<int>(json, r'limit')!,
        offset: mapValueOfType<int>(json, r'offset')!,
        total: mapValueOfType<int>(json, r'total')!,
        hasMore: mapValueOfType<bool>(json, r'has_more')!,
        nextOffset: mapValueOfType<int>(json, r'next_offset'),
      );
    }
    return null;
  }

  static List<MailboxPagination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxPagination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxPagination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxPagination> mapFromJson(dynamic json) {
    final map = <String, MailboxPagination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxPagination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxPagination-objects as value to a dart map
  static Map<String, List<MailboxPagination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxPagination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxPagination.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'limit',
    'offset',
    'total',
    'has_more',
    'next_offset',
  };
}


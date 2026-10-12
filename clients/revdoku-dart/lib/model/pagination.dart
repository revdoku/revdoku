//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class Pagination {
  /// Returns a new [Pagination] instance.
  Pagination({
    required this.limit,
    required this.hasMore,
    required this.nextCursor,
  });

  /// Minimum value: 1
  /// Maximum value: 200
  int limit;

  /// True when another page exists.
  bool hasMore;

  /// Cursor for the next page; null on the last page. Email lists always return a cursor so that you can poll for new mail.
  String? nextCursor;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Pagination &&
    other.limit == limit &&
    other.hasMore == hasMore &&
    other.nextCursor == nextCursor;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (limit.hashCode) +
    (hasMore.hashCode) +
    (nextCursor == null ? 0 : nextCursor!.hashCode);

  @override
  String toString() => 'Pagination[limit=$limit, hasMore=$hasMore, nextCursor=$nextCursor]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'limit'] = this.limit;
      json[r'has_more'] = this.hasMore;
    if (this.nextCursor != null) {
      json[r'next_cursor'] = this.nextCursor;
    } else {
      json[r'next_cursor'] = null;
    }
    return json;
  }

  /// Returns a new [Pagination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Pagination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'limit'), 'Required key "Pagination[limit]" is missing from JSON.');
        assert(json[r'limit'] != null, 'Required key "Pagination[limit]" has a null value in JSON.');
        assert(json.containsKey(r'has_more'), 'Required key "Pagination[has_more]" is missing from JSON.');
        assert(json[r'has_more'] != null, 'Required key "Pagination[has_more]" has a null value in JSON.');
        assert(json.containsKey(r'next_cursor'), 'Required key "Pagination[next_cursor]" is missing from JSON.');
        return true;
      }());

      return Pagination(
        limit: mapValueOfType<int>(json, r'limit')!,
        hasMore: mapValueOfType<bool>(json, r'has_more')!,
        nextCursor: mapValueOfType<String>(json, r'next_cursor'),
      );
    }
    return null;
  }

  static List<Pagination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Pagination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Pagination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Pagination> mapFromJson(dynamic json) {
    final map = <String, Pagination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Pagination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Pagination-objects as value to a dart map
  static Map<String, List<Pagination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Pagination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Pagination.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'limit',
    'has_more',
    'next_cursor',
  };
}


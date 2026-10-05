//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class FilePagination {
  /// Returns a new [FilePagination] instance.
  FilePagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
    required this.hasMore,
    required this.nextOffset,
  });

  int limit;

  int offset;

  int count;

  int total;

  bool hasMore;

  int? nextOffset;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FilePagination &&
    other.limit == limit &&
    other.offset == offset &&
    other.count == count &&
    other.total == total &&
    other.hasMore == hasMore &&
    other.nextOffset == nextOffset;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (limit.hashCode) +
    (offset.hashCode) +
    (count.hashCode) +
    (total.hashCode) +
    (hasMore.hashCode) +
    (nextOffset == null ? 0 : nextOffset!.hashCode);

  @override
  String toString() => 'FilePagination[limit=$limit, offset=$offset, count=$count, total=$total, hasMore=$hasMore, nextOffset=$nextOffset]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'limit'] = this.limit;
      json[r'offset'] = this.offset;
      json[r'count'] = this.count;
      json[r'total'] = this.total;
      json[r'has_more'] = this.hasMore;
    if (this.nextOffset != null) {
      json[r'next_offset'] = this.nextOffset;
    } else {
      json[r'next_offset'] = null;
    }
    return json;
  }

  /// Returns a new [FilePagination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FilePagination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'limit'), 'Required key "FilePagination[limit]" is missing from JSON.');
        assert(json[r'limit'] != null, 'Required key "FilePagination[limit]" has a null value in JSON.');
        assert(json.containsKey(r'offset'), 'Required key "FilePagination[offset]" is missing from JSON.');
        assert(json[r'offset'] != null, 'Required key "FilePagination[offset]" has a null value in JSON.');
        assert(json.containsKey(r'count'), 'Required key "FilePagination[count]" is missing from JSON.');
        assert(json[r'count'] != null, 'Required key "FilePagination[count]" has a null value in JSON.');
        assert(json.containsKey(r'total'), 'Required key "FilePagination[total]" is missing from JSON.');
        assert(json[r'total'] != null, 'Required key "FilePagination[total]" has a null value in JSON.');
        assert(json.containsKey(r'has_more'), 'Required key "FilePagination[has_more]" is missing from JSON.');
        assert(json[r'has_more'] != null, 'Required key "FilePagination[has_more]" has a null value in JSON.');
        assert(json.containsKey(r'next_offset'), 'Required key "FilePagination[next_offset]" is missing from JSON.');
        return true;
      }());

      return FilePagination(
        limit: mapValueOfType<int>(json, r'limit')!,
        offset: mapValueOfType<int>(json, r'offset')!,
        count: mapValueOfType<int>(json, r'count')!,
        total: mapValueOfType<int>(json, r'total')!,
        hasMore: mapValueOfType<bool>(json, r'has_more')!,
        nextOffset: mapValueOfType<int>(json, r'next_offset'),
      );
    }
    return null;
  }

  static List<FilePagination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FilePagination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FilePagination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FilePagination> mapFromJson(dynamic json) {
    final map = <String, FilePagination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FilePagination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FilePagination-objects as value to a dart map
  static Map<String, List<FilePagination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FilePagination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FilePagination.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'limit',
    'offset',
    'count',
    'total',
    'has_more',
    'next_offset',
  };
}


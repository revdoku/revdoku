//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailPagination {
  /// Returns a new [EmailPagination] instance.
  EmailPagination({
    required this.limit,
    required this.hasMore,
    required this.nextCursor,
  });

  /// Minimum value: 1
  /// Maximum value: 100
  int limit;

  bool hasMore;

  String nextCursor;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailPagination &&
    other.limit == limit &&
    other.hasMore == hasMore &&
    other.nextCursor == nextCursor;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (limit.hashCode) +
    (hasMore.hashCode) +
    (nextCursor.hashCode);

  @override
  String toString() => 'EmailPagination[limit=$limit, hasMore=$hasMore, nextCursor=$nextCursor]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'limit'] = this.limit;
      json[r'has_more'] = this.hasMore;
      json[r'next_cursor'] = this.nextCursor;
    return json;
  }

  /// Returns a new [EmailPagination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailPagination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'limit'), 'Required key "EmailPagination[limit]" is missing from JSON.');
        assert(json[r'limit'] != null, 'Required key "EmailPagination[limit]" has a null value in JSON.');
        assert(json.containsKey(r'has_more'), 'Required key "EmailPagination[has_more]" is missing from JSON.');
        assert(json[r'has_more'] != null, 'Required key "EmailPagination[has_more]" has a null value in JSON.');
        assert(json.containsKey(r'next_cursor'), 'Required key "EmailPagination[next_cursor]" is missing from JSON.');
        assert(json[r'next_cursor'] != null, 'Required key "EmailPagination[next_cursor]" has a null value in JSON.');
        return true;
      }());

      return EmailPagination(
        limit: mapValueOfType<int>(json, r'limit')!,
        hasMore: mapValueOfType<bool>(json, r'has_more')!,
        nextCursor: mapValueOfType<String>(json, r'next_cursor')!,
      );
    }
    return null;
  }

  static List<EmailPagination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailPagination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailPagination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailPagination> mapFromJson(dynamic json) {
    final map = <String, EmailPagination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailPagination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailPagination-objects as value to a dart map
  static Map<String, List<EmailPagination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailPagination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailPagination.listFromJson(entry.value, growable: growable,);
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


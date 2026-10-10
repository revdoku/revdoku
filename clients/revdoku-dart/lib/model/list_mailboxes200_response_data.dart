//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ListMailboxes200ResponseData {
  /// Returns a new [ListMailboxes200ResponseData] instance.
  ListMailboxes200ResponseData({
    this.mailboxes = const [],
    required this.counts,
    required this.pagination,
  });

  List<Mailbox> mailboxes;

  MailboxCounts counts;

  MailboxPagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ListMailboxes200ResponseData &&
    _deepEquality.equals(other.mailboxes, mailboxes) &&
    other.counts == counts &&
    other.pagination == pagination;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mailboxes.hashCode) +
    (counts.hashCode) +
    (pagination.hashCode);

  @override
  String toString() => 'ListMailboxes200ResponseData[mailboxes=$mailboxes, counts=$counts, pagination=$pagination]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mailboxes'] = this.mailboxes;
      json[r'counts'] = this.counts;
      json[r'pagination'] = this.pagination;
    return json;
  }

  /// Returns a new [ListMailboxes200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ListMailboxes200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mailboxes'), 'Required key "ListMailboxes200ResponseData[mailboxes]" is missing from JSON.');
        assert(json[r'mailboxes'] != null, 'Required key "ListMailboxes200ResponseData[mailboxes]" has a null value in JSON.');
        assert(json.containsKey(r'counts'), 'Required key "ListMailboxes200ResponseData[counts]" is missing from JSON.');
        assert(json[r'counts'] != null, 'Required key "ListMailboxes200ResponseData[counts]" has a null value in JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "ListMailboxes200ResponseData[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "ListMailboxes200ResponseData[pagination]" has a null value in JSON.');
        return true;
      }());

      return ListMailboxes200ResponseData(
        mailboxes: Mailbox.listFromJson(json[r'mailboxes']),
        counts: MailboxCounts.fromJson(json[r'counts'])!,
        pagination: MailboxPagination.fromJson(json[r'pagination'])!,
      );
    }
    return null;
  }

  static List<ListMailboxes200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ListMailboxes200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ListMailboxes200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ListMailboxes200ResponseData> mapFromJson(dynamic json) {
    final map = <String, ListMailboxes200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ListMailboxes200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ListMailboxes200ResponseData-objects as value to a dart map
  static Map<String, List<ListMailboxes200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ListMailboxes200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ListMailboxes200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mailboxes',
    'counts',
    'pagination',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ListEmails200ResponseData {
  /// Returns a new [ListEmails200ResponseData] instance.
  ListEmails200ResponseData({
    this.emails = const [],
    required this.pagination,
  });

  List<EmailSummary> emails;

  EmailPagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ListEmails200ResponseData &&
    _deepEquality.equals(other.emails, emails) &&
    other.pagination == pagination;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (emails.hashCode) +
    (pagination.hashCode);

  @override
  String toString() => 'ListEmails200ResponseData[emails=$emails, pagination=$pagination]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'emails'] = this.emails;
      json[r'pagination'] = this.pagination;
    return json;
  }

  /// Returns a new [ListEmails200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ListEmails200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'emails'), 'Required key "ListEmails200ResponseData[emails]" is missing from JSON.');
        assert(json[r'emails'] != null, 'Required key "ListEmails200ResponseData[emails]" has a null value in JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "ListEmails200ResponseData[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "ListEmails200ResponseData[pagination]" has a null value in JSON.');
        return true;
      }());

      return ListEmails200ResponseData(
        emails: EmailSummary.listFromJson(json[r'emails']),
        pagination: EmailPagination.fromJson(json[r'pagination'])!,
      );
    }
    return null;
  }

  static List<ListEmails200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ListEmails200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ListEmails200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ListEmails200ResponseData> mapFromJson(dynamic json) {
    final map = <String, ListEmails200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ListEmails200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ListEmails200ResponseData-objects as value to a dart map
  static Map<String, List<ListEmails200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ListEmails200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ListEmails200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'emails',
    'pagination',
  };
}


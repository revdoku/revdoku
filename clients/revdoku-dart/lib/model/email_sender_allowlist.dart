//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailSenderAllowlist {
  /// Returns a new [EmailSenderAllowlist] instance.
  EmailSenderAllowlist({
    required this.enabled,
    this.entries = const [],
    required this.version,
    required this.maxEntries,
    required this.editable,
  });

  bool enabled;

  List<String> entries;

  String version;

  int maxEntries;

  bool editable;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailSenderAllowlist &&
    other.enabled == enabled &&
    _deepEquality.equals(other.entries, entries) &&
    other.version == version &&
    other.maxEntries == maxEntries &&
    other.editable == editable;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (enabled.hashCode) +
    (entries.hashCode) +
    (version.hashCode) +
    (maxEntries.hashCode) +
    (editable.hashCode);

  @override
  String toString() => 'EmailSenderAllowlist[enabled=$enabled, entries=$entries, version=$version, maxEntries=$maxEntries, editable=$editable]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'enabled'] = this.enabled;
      json[r'entries'] = this.entries;
      json[r'version'] = this.version;
      json[r'max_entries'] = this.maxEntries;
      json[r'editable'] = this.editable;
    return json;
  }

  /// Returns a new [EmailSenderAllowlist] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailSenderAllowlist? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'enabled'), 'Required key "EmailSenderAllowlist[enabled]" is missing from JSON.');
        assert(json[r'enabled'] != null, 'Required key "EmailSenderAllowlist[enabled]" has a null value in JSON.');
        assert(json.containsKey(r'entries'), 'Required key "EmailSenderAllowlist[entries]" is missing from JSON.');
        assert(json[r'entries'] != null, 'Required key "EmailSenderAllowlist[entries]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "EmailSenderAllowlist[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "EmailSenderAllowlist[version]" has a null value in JSON.');
        assert(json.containsKey(r'max_entries'), 'Required key "EmailSenderAllowlist[max_entries]" is missing from JSON.');
        assert(json[r'max_entries'] != null, 'Required key "EmailSenderAllowlist[max_entries]" has a null value in JSON.');
        assert(json.containsKey(r'editable'), 'Required key "EmailSenderAllowlist[editable]" is missing from JSON.');
        assert(json[r'editable'] != null, 'Required key "EmailSenderAllowlist[editable]" has a null value in JSON.');
        return true;
      }());

      return EmailSenderAllowlist(
        enabled: mapValueOfType<bool>(json, r'enabled')!,
        entries: json[r'entries'] is Iterable
            ? (json[r'entries'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        version: mapValueOfType<String>(json, r'version')!,
        maxEntries: mapValueOfType<int>(json, r'max_entries')!,
        editable: mapValueOfType<bool>(json, r'editable')!,
      );
    }
    return null;
  }

  static List<EmailSenderAllowlist> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSenderAllowlist>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSenderAllowlist.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailSenderAllowlist> mapFromJson(dynamic json) {
    final map = <String, EmailSenderAllowlist>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailSenderAllowlist.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailSenderAllowlist-objects as value to a dart map
  static Map<String, List<EmailSenderAllowlist>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailSenderAllowlist>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailSenderAllowlist.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'enabled',
    'entries',
    'version',
    'max_entries',
    'editable',
  };
}


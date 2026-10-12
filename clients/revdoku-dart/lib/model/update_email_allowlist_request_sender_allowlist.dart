//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UpdateEmailAllowlistRequestSenderAllowlist {
  /// Returns a new [UpdateEmailAllowlistRequestSenderAllowlist] instance.
  UpdateEmailAllowlistRequestSenderAllowlist({
    required this.enabled,
    this.entries = const [],
  });

  bool enabled;

  List<String> entries;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateEmailAllowlistRequestSenderAllowlist &&
    other.enabled == enabled &&
    _deepEquality.equals(other.entries, entries);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (enabled.hashCode) +
    (entries.hashCode);

  @override
  String toString() => 'UpdateEmailAllowlistRequestSenderAllowlist[enabled=$enabled, entries=$entries]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'enabled'] = this.enabled;
      json[r'entries'] = this.entries;
    return json;
  }

  /// Returns a new [UpdateEmailAllowlistRequestSenderAllowlist] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateEmailAllowlistRequestSenderAllowlist? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'enabled'), 'Required key "UpdateEmailAllowlistRequestSenderAllowlist[enabled]" is missing from JSON.');
        assert(json[r'enabled'] != null, 'Required key "UpdateEmailAllowlistRequestSenderAllowlist[enabled]" has a null value in JSON.');
        assert(json.containsKey(r'entries'), 'Required key "UpdateEmailAllowlistRequestSenderAllowlist[entries]" is missing from JSON.');
        assert(json[r'entries'] != null, 'Required key "UpdateEmailAllowlistRequestSenderAllowlist[entries]" has a null value in JSON.');
        return true;
      }());

      return UpdateEmailAllowlistRequestSenderAllowlist(
        enabled: mapValueOfType<bool>(json, r'enabled')!,
        entries: json[r'entries'] is Iterable
            ? (json[r'entries'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<UpdateEmailAllowlistRequestSenderAllowlist> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateEmailAllowlistRequestSenderAllowlist>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateEmailAllowlistRequestSenderAllowlist.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateEmailAllowlistRequestSenderAllowlist> mapFromJson(dynamic json) {
    final map = <String, UpdateEmailAllowlistRequestSenderAllowlist>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateEmailAllowlistRequestSenderAllowlist.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateEmailAllowlistRequestSenderAllowlist-objects as value to a dart map
  static Map<String, List<UpdateEmailAllowlistRequestSenderAllowlist>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateEmailAllowlistRequestSenderAllowlist>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateEmailAllowlistRequestSenderAllowlist.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'enabled',
    'entries',
  };
}


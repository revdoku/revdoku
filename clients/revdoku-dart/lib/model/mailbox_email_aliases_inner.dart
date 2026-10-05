//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailAliasesInner {
  /// Returns a new [MailboxEmailAliasesInner] instance.
  MailboxEmailAliasesInner({
    required this.id,
    required this.address,
    required this.active,
  });

  String id;

  String address;

  /// Within the current alias allowance. Mailbox receiving holds still apply.
  bool active;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailAliasesInner &&
    other.id == id &&
    other.address == address &&
    other.active == active;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (address.hashCode) +
    (active.hashCode);

  @override
  String toString() => 'MailboxEmailAliasesInner[id=$id, address=$address, active=$active]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'address'] = this.address;
      json[r'active'] = this.active;
    return json;
  }

  /// Returns a new [MailboxEmailAliasesInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailAliasesInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "MailboxEmailAliasesInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "MailboxEmailAliasesInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'address'), 'Required key "MailboxEmailAliasesInner[address]" is missing from JSON.');
        assert(json[r'address'] != null, 'Required key "MailboxEmailAliasesInner[address]" has a null value in JSON.');
        assert(json.containsKey(r'active'), 'Required key "MailboxEmailAliasesInner[active]" is missing from JSON.');
        assert(json[r'active'] != null, 'Required key "MailboxEmailAliasesInner[active]" has a null value in JSON.');
        return true;
      }());

      return MailboxEmailAliasesInner(
        id: mapValueOfType<String>(json, r'id')!,
        address: mapValueOfType<String>(json, r'address')!,
        active: mapValueOfType<bool>(json, r'active')!,
      );
    }
    return null;
  }

  static List<MailboxEmailAliasesInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailAliasesInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailAliasesInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailAliasesInner> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailAliasesInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailAliasesInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailAliasesInner-objects as value to a dart map
  static Map<String, List<MailboxEmailAliasesInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailAliasesInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailAliasesInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'address',
    'active',
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UpdateMailboxEmailAllowlist200ResponseData {
  /// Returns a new [UpdateMailboxEmailAllowlist200ResponseData] instance.
  UpdateMailboxEmailAllowlist200ResponseData({
    required this.senderAllowlist,
  });

  EmailSenderAllowlist senderAllowlist;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateMailboxEmailAllowlist200ResponseData &&
    other.senderAllowlist == senderAllowlist;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (senderAllowlist.hashCode);

  @override
  String toString() => 'UpdateMailboxEmailAllowlist200ResponseData[senderAllowlist=$senderAllowlist]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'sender_allowlist'] = this.senderAllowlist;
    return json;
  }

  /// Returns a new [UpdateMailboxEmailAllowlist200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateMailboxEmailAllowlist200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'sender_allowlist'), 'Required key "UpdateMailboxEmailAllowlist200ResponseData[sender_allowlist]" is missing from JSON.');
        assert(json[r'sender_allowlist'] != null, 'Required key "UpdateMailboxEmailAllowlist200ResponseData[sender_allowlist]" has a null value in JSON.');
        return true;
      }());

      return UpdateMailboxEmailAllowlist200ResponseData(
        senderAllowlist: EmailSenderAllowlist.fromJson(json[r'sender_allowlist'])!,
      );
    }
    return null;
  }

  static List<UpdateMailboxEmailAllowlist200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateMailboxEmailAllowlist200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateMailboxEmailAllowlist200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateMailboxEmailAllowlist200ResponseData> mapFromJson(dynamic json) {
    final map = <String, UpdateMailboxEmailAllowlist200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateMailboxEmailAllowlist200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateMailboxEmailAllowlist200ResponseData-objects as value to a dart map
  static Map<String, List<UpdateMailboxEmailAllowlist200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateMailboxEmailAllowlist200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateMailboxEmailAllowlist200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sender_allowlist',
  };
}


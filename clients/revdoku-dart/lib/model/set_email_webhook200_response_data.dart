//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SetEmailWebhook200ResponseData {
  /// Returns a new [SetEmailWebhook200ResponseData] instance.
  SetEmailWebhook200ResponseData({
    required this.webhook,
  });

  SetEmailWebhook200ResponseDataWebhook webhook;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetEmailWebhook200ResponseData &&
    other.webhook == webhook;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (webhook.hashCode);

  @override
  String toString() => 'SetEmailWebhook200ResponseData[webhook=$webhook]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'webhook'] = this.webhook;
    return json;
  }

  /// Returns a new [SetEmailWebhook200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetEmailWebhook200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'webhook'), 'Required key "SetEmailWebhook200ResponseData[webhook]" is missing from JSON.');
        assert(json[r'webhook'] != null, 'Required key "SetEmailWebhook200ResponseData[webhook]" has a null value in JSON.');
        return true;
      }());

      return SetEmailWebhook200ResponseData(
        webhook: SetEmailWebhook200ResponseDataWebhook.fromJson(json[r'webhook'])!,
      );
    }
    return null;
  }

  static List<SetEmailWebhook200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetEmailWebhook200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetEmailWebhook200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetEmailWebhook200ResponseData> mapFromJson(dynamic json) {
    final map = <String, SetEmailWebhook200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetEmailWebhook200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetEmailWebhook200ResponseData-objects as value to a dart map
  static Map<String, List<SetEmailWebhook200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetEmailWebhook200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetEmailWebhook200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'webhook',
  };
}


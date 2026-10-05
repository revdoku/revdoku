//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetEmailWebhook200ResponseData {
  /// Returns a new [GetEmailWebhook200ResponseData] instance.
  GetEmailWebhook200ResponseData({
    required this.webhook,
  });

  GetEmailWebhook200ResponseDataWebhook? webhook;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetEmailWebhook200ResponseData &&
    other.webhook == webhook;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (webhook == null ? 0 : webhook!.hashCode);

  @override
  String toString() => 'GetEmailWebhook200ResponseData[webhook=$webhook]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.webhook != null) {
      json[r'webhook'] = this.webhook;
    } else {
      json[r'webhook'] = null;
    }
    return json;
  }

  /// Returns a new [GetEmailWebhook200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetEmailWebhook200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'webhook'), 'Required key "GetEmailWebhook200ResponseData[webhook]" is missing from JSON.');
        return true;
      }());

      return GetEmailWebhook200ResponseData(
        webhook: GetEmailWebhook200ResponseDataWebhook.fromJson(json[r'webhook']),
      );
    }
    return null;
  }

  static List<GetEmailWebhook200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailWebhook200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailWebhook200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetEmailWebhook200ResponseData> mapFromJson(dynamic json) {
    final map = <String, GetEmailWebhook200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetEmailWebhook200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetEmailWebhook200ResponseData-objects as value to a dart map
  static Map<String, List<GetEmailWebhook200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetEmailWebhook200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetEmailWebhook200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'webhook',
  };
}


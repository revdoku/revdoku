//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetEmailWebhook200ResponseDataWebhook {
  /// Returns a new [GetEmailWebhook200ResponseDataWebhook] instance.
  GetEmailWebhook200ResponseDataWebhook({
    required this.url,
    required this.event,
  });

  String url;

  GetEmailWebhook200ResponseDataWebhookEventEnum event;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetEmailWebhook200ResponseDataWebhook &&
    other.url == url &&
    other.event == event;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (event.hashCode);

  @override
  String toString() => 'GetEmailWebhook200ResponseDataWebhook[url=$url, event=$event]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'event'] = this.event;
    return json;
  }

  /// Returns a new [GetEmailWebhook200ResponseDataWebhook] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetEmailWebhook200ResponseDataWebhook? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "GetEmailWebhook200ResponseDataWebhook[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "GetEmailWebhook200ResponseDataWebhook[url]" has a null value in JSON.');
        assert(json.containsKey(r'event'), 'Required key "GetEmailWebhook200ResponseDataWebhook[event]" is missing from JSON.');
        assert(json[r'event'] != null, 'Required key "GetEmailWebhook200ResponseDataWebhook[event]" has a null value in JSON.');
        return true;
      }());

      return GetEmailWebhook200ResponseDataWebhook(
        url: mapValueOfType<String>(json, r'url')!,
        event: GetEmailWebhook200ResponseDataWebhookEventEnum.fromJson(json[r'event'])!,
      );
    }
    return null;
  }

  static List<GetEmailWebhook200ResponseDataWebhook> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailWebhook200ResponseDataWebhook>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailWebhook200ResponseDataWebhook.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetEmailWebhook200ResponseDataWebhook> mapFromJson(dynamic json) {
    final map = <String, GetEmailWebhook200ResponseDataWebhook>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetEmailWebhook200ResponseDataWebhook.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetEmailWebhook200ResponseDataWebhook-objects as value to a dart map
  static Map<String, List<GetEmailWebhook200ResponseDataWebhook>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetEmailWebhook200ResponseDataWebhook>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetEmailWebhook200ResponseDataWebhook.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'event',
  };
}


enum GetEmailWebhook200ResponseDataWebhookEventEnum {
  emailPeriodReceived._(r'email.received'),
  ;

  /// Instantiate a new enum with the provided value.
  const GetEmailWebhook200ResponseDataWebhookEventEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [GetEmailWebhook200ResponseDataWebhookEventEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static GetEmailWebhook200ResponseDataWebhookEventEnum? fromJson(dynamic value) => GetEmailWebhook200ResponseDataWebhookEventEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [GetEmailWebhook200ResponseDataWebhookEventEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<GetEmailWebhook200ResponseDataWebhookEventEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailWebhook200ResponseDataWebhookEventEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailWebhook200ResponseDataWebhookEventEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [GetEmailWebhook200ResponseDataWebhookEventEnum] to String,
/// and [decode] dynamic data back to [GetEmailWebhook200ResponseDataWebhookEventEnum].
class GetEmailWebhook200ResponseDataWebhookEventEnumTypeTransformer {
  factory GetEmailWebhook200ResponseDataWebhookEventEnumTypeTransformer() => _instance ??= const GetEmailWebhook200ResponseDataWebhookEventEnumTypeTransformer._();

  const GetEmailWebhook200ResponseDataWebhookEventEnumTypeTransformer._();

  String encode(GetEmailWebhook200ResponseDataWebhookEventEnum data) => data._value;

  /// Returns the instance of [GetEmailWebhook200ResponseDataWebhookEventEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  GetEmailWebhook200ResponseDataWebhookEventEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is GetEmailWebhook200ResponseDataWebhookEventEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'email.received': return GetEmailWebhook200ResponseDataWebhookEventEnum.emailPeriodReceived;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static GetEmailWebhook200ResponseDataWebhookEventEnumTypeTransformer? _instance;
}



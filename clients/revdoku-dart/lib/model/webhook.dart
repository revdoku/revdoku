//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class Webhook {
  /// Returns a new [Webhook] instance.
  Webhook({
    required this.url,
    required this.event,
  });

  String url;

  WebhookEventEnum event;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Webhook &&
    other.url == url &&
    other.event == event;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (event.hashCode);

  @override
  String toString() => 'Webhook[url=$url, event=$event]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'event'] = this.event;
    return json;
  }

  /// Returns a new [Webhook] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Webhook? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "Webhook[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "Webhook[url]" has a null value in JSON.');
        assert(json.containsKey(r'event'), 'Required key "Webhook[event]" is missing from JSON.');
        assert(json[r'event'] != null, 'Required key "Webhook[event]" has a null value in JSON.');
        return true;
      }());

      return Webhook(
        url: mapValueOfType<String>(json, r'url')!,
        event: WebhookEventEnum.fromJson(json[r'event'])!,
      );
    }
    return null;
  }

  static List<Webhook> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Webhook>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Webhook.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Webhook> mapFromJson(dynamic json) {
    final map = <String, Webhook>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Webhook.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Webhook-objects as value to a dart map
  static Map<String, List<Webhook>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Webhook>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Webhook.listFromJson(entry.value, growable: growable,);
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


enum WebhookEventEnum {
  emailPeriodReceived._(r'email.received'),
  ;

  /// Instantiate a new enum with the provided value.
  const WebhookEventEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [WebhookEventEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static WebhookEventEnum? fromJson(dynamic value) => WebhookEventEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [WebhookEventEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<WebhookEventEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WebhookEventEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WebhookEventEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WebhookEventEnum] to String,
/// and [decode] dynamic data back to [WebhookEventEnum].
class WebhookEventEnumTypeTransformer {
  factory WebhookEventEnumTypeTransformer() => _instance ??= const WebhookEventEnumTypeTransformer._();

  const WebhookEventEnumTypeTransformer._();

  String encode(WebhookEventEnum data) => data._value;

  /// Returns the instance of [WebhookEventEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WebhookEventEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is WebhookEventEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'email.received': return WebhookEventEnum.emailPeriodReceived;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static WebhookEventEnumTypeTransformer? _instance;
}



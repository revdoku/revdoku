//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class WebhookWithSecret {
  /// Returns a new [WebhookWithSecret] instance.
  WebhookWithSecret({
    required this.url,
    required this.event,
    this.signingSecret,
  });

  String url;

  WebhookWithSecretEventEnum event;

  /// Returned once, when this request issues a secret: a new URL or rotate_secret=true. Store it to verify signatures.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? signingSecret;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WebhookWithSecret &&
    other.url == url &&
    other.event == event &&
    other.signingSecret == signingSecret;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (event.hashCode) +
    (signingSecret == null ? 0 : signingSecret!.hashCode);

  @override
  String toString() => 'WebhookWithSecret[url=$url, event=$event, signingSecret=$signingSecret]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'event'] = this.event;
    if (this.signingSecret != null) {
      json[r'signing_secret'] = this.signingSecret;
    }
    return json;
  }

  /// Returns a new [WebhookWithSecret] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WebhookWithSecret? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "WebhookWithSecret[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "WebhookWithSecret[url]" has a null value in JSON.');
        assert(json.containsKey(r'event'), 'Required key "WebhookWithSecret[event]" is missing from JSON.');
        assert(json[r'event'] != null, 'Required key "WebhookWithSecret[event]" has a null value in JSON.');
        return true;
      }());

      return WebhookWithSecret(
        url: mapValueOfType<String>(json, r'url')!,
        event: WebhookWithSecretEventEnum.fromJson(json[r'event'])!,
        signingSecret: mapValueOfType<String>(json, r'signing_secret'),
      );
    }
    return null;
  }

  static List<WebhookWithSecret> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WebhookWithSecret>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WebhookWithSecret.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WebhookWithSecret> mapFromJson(dynamic json) {
    final map = <String, WebhookWithSecret>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WebhookWithSecret.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WebhookWithSecret-objects as value to a dart map
  static Map<String, List<WebhookWithSecret>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WebhookWithSecret>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WebhookWithSecret.listFromJson(entry.value, growable: growable,);
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


enum WebhookWithSecretEventEnum {
  emailPeriodReceived._(r'email.received'),
  ;

  /// Instantiate a new enum with the provided value.
  const WebhookWithSecretEventEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [WebhookWithSecretEventEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static WebhookWithSecretEventEnum? fromJson(dynamic value) => WebhookWithSecretEventEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [WebhookWithSecretEventEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<WebhookWithSecretEventEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WebhookWithSecretEventEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WebhookWithSecretEventEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WebhookWithSecretEventEnum] to String,
/// and [decode] dynamic data back to [WebhookWithSecretEventEnum].
class WebhookWithSecretEventEnumTypeTransformer {
  factory WebhookWithSecretEventEnumTypeTransformer() => _instance ??= const WebhookWithSecretEventEnumTypeTransformer._();

  const WebhookWithSecretEventEnumTypeTransformer._();

  String encode(WebhookWithSecretEventEnum data) => data._value;

  /// Returns the instance of [WebhookWithSecretEventEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WebhookWithSecretEventEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is WebhookWithSecretEventEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'email.received': return WebhookWithSecretEventEnum.emailPeriodReceived;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static WebhookWithSecretEventEnumTypeTransformer? _instance;
}



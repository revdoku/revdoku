//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailReceivedEvent {
  /// Returns a new [EmailReceivedEvent] instance.
  EmailReceivedEvent({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.data,
  });

  /// Stable event ID; deduplicate across retries.
  String id;

  EmailReceivedEventTypeEnum type;

  DateTime createdAt;

  EmailReceivedEventData data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailReceivedEvent &&
    other.id == id &&
    other.type == type &&
    other.createdAt == createdAt &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (createdAt.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'EmailReceivedEvent[id=$id, type=$type, createdAt=$createdAt, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'created_at'] = this.createdAt.toUtc().toIso8601String();
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [EmailReceivedEvent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailReceivedEvent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "EmailReceivedEvent[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "EmailReceivedEvent[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "EmailReceivedEvent[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "EmailReceivedEvent[type]" has a null value in JSON.');
        assert(json.containsKey(r'created_at'), 'Required key "EmailReceivedEvent[created_at]" is missing from JSON.');
        assert(json[r'created_at'] != null, 'Required key "EmailReceivedEvent[created_at]" has a null value in JSON.');
        assert(json.containsKey(r'data'), 'Required key "EmailReceivedEvent[data]" is missing from JSON.');
        assert(json[r'data'] != null, 'Required key "EmailReceivedEvent[data]" has a null value in JSON.');
        return true;
      }());

      return EmailReceivedEvent(
        id: mapValueOfType<String>(json, r'id')!,
        type: EmailReceivedEventTypeEnum.fromJson(json[r'type'])!,
        createdAt: mapDateTime(json, r'created_at', r'')!,
        data: EmailReceivedEventData.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<EmailReceivedEvent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailReceivedEvent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailReceivedEvent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailReceivedEvent> mapFromJson(dynamic json) {
    final map = <String, EmailReceivedEvent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailReceivedEvent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailReceivedEvent-objects as value to a dart map
  static Map<String, List<EmailReceivedEvent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailReceivedEvent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailReceivedEvent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'created_at',
    'data',
  };
}


enum EmailReceivedEventTypeEnum {
  emailPeriodReceived._(r'email.received'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailReceivedEventTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailReceivedEventTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailReceivedEventTypeEnum? fromJson(dynamic value) => EmailReceivedEventTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailReceivedEventTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailReceivedEventTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailReceivedEventTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailReceivedEventTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailReceivedEventTypeEnum] to String,
/// and [decode] dynamic data back to [EmailReceivedEventTypeEnum].
class EmailReceivedEventTypeEnumTypeTransformer {
  factory EmailReceivedEventTypeEnumTypeTransformer() => _instance ??= const EmailReceivedEventTypeEnumTypeTransformer._();

  const EmailReceivedEventTypeEnumTypeTransformer._();

  String encode(EmailReceivedEventTypeEnum data) => data._value;

  /// Returns the instance of [EmailReceivedEventTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailReceivedEventTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailReceivedEventTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'email.received': return EmailReceivedEventTypeEnum.emailPeriodReceived;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailReceivedEventTypeEnumTypeTransformer? _instance;
}



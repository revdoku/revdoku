//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDelivery {
  /// Returns a new [EmailDelivery] instance.
  EmailDelivery({
    required this.status,
    this.recipients = const {},
  });

  /// uncertain: the provider result is unknown. Do not send again before you check the sent list.
  EmailDeliveryStatusEnum status;

  /// Status for each recipient address: queued, sent, delivered, bounced, bounced_temporarily, complained or rejected.
  Map<String, String> recipients;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDelivery &&
    other.status == status &&
    _deepEquality.equals(other.recipients, recipients);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status.hashCode) +
    (recipients.hashCode);

  @override
  String toString() => 'EmailDelivery[status=$status, recipients=$recipients]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'status'] = this.status;
      json[r'recipients'] = this.recipients;
    return json;
  }

  /// Returns a new [EmailDelivery] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDelivery? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'status'), 'Required key "EmailDelivery[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "EmailDelivery[status]" has a null value in JSON.');
        assert(json.containsKey(r'recipients'), 'Required key "EmailDelivery[recipients]" is missing from JSON.');
        assert(json[r'recipients'] != null, 'Required key "EmailDelivery[recipients]" has a null value in JSON.');
        return true;
      }());

      return EmailDelivery(
        status: EmailDeliveryStatusEnum.fromJson(json[r'status'])!,
        recipients: mapCastOfType<String, String>(json, r'recipients')!,
      );
    }
    return null;
  }

  static List<EmailDelivery> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDelivery>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDelivery.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDelivery> mapFromJson(dynamic json) {
    final map = <String, EmailDelivery>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDelivery.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDelivery-objects as value to a dart map
  static Map<String, List<EmailDelivery>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDelivery>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDelivery.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
    'recipients',
  };
}

/// uncertain: the provider result is unknown. Do not send again before you check the sent list.
enum EmailDeliveryStatusEnum {
  queued._(r'queued'),
  sending._(r'sending'),
  sent._(r'sent'),
  failed._(r'failed'),
  uncertain._(r'uncertain'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailDeliveryStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailDeliveryStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailDeliveryStatusEnum? fromJson(dynamic value) => EmailDeliveryStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailDeliveryStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailDeliveryStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDeliveryStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDeliveryStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailDeliveryStatusEnum] to String,
/// and [decode] dynamic data back to [EmailDeliveryStatusEnum].
class EmailDeliveryStatusEnumTypeTransformer {
  factory EmailDeliveryStatusEnumTypeTransformer() => _instance ??= const EmailDeliveryStatusEnumTypeTransformer._();

  const EmailDeliveryStatusEnumTypeTransformer._();

  String encode(EmailDeliveryStatusEnum data) => data._value;

  /// Returns the instance of [EmailDeliveryStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailDeliveryStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailDeliveryStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'queued': return EmailDeliveryStatusEnum.queued;
        case r'sending': return EmailDeliveryStatusEnum.sending;
        case r'sent': return EmailDeliveryStatusEnum.sent;
        case r'failed': return EmailDeliveryStatusEnum.failed;
        case r'uncertain': return EmailDeliveryStatusEnum.uncertain;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailDeliveryStatusEnumTypeTransformer? _instance;
}



//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailSubscription {
  /// Returns a new [EmailSubscription] instance.
  EmailSubscription({
    required this.token,
    required this.expiresIn,
    required this.channel,
    required this.accountId,
    required this.mailboxId,
    required this.websocketUrl,
  });

  String token;

  EmailSubscriptionExpiresInEnum expiresIn;

  EmailSubscriptionChannelEnum channel;

  String accountId;

  String mailboxId;

  /// Base WebSocket endpoint. Append email_subscription_token as a query parameter.
  String websocketUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailSubscription &&
    other.token == token &&
    other.expiresIn == expiresIn &&
    other.channel == channel &&
    other.accountId == accountId &&
    other.mailboxId == mailboxId &&
    other.websocketUrl == websocketUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode) +
    (expiresIn.hashCode) +
    (channel.hashCode) +
    (accountId.hashCode) +
    (mailboxId.hashCode) +
    (websocketUrl.hashCode);

  @override
  String toString() => 'EmailSubscription[token=$token, expiresIn=$expiresIn, channel=$channel, accountId=$accountId, mailboxId=$mailboxId, websocketUrl=$websocketUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'token'] = this.token;
      json[r'expires_in'] = this.expiresIn;
      json[r'channel'] = this.channel;
      json[r'account_id'] = this.accountId;
      json[r'mailbox_id'] = this.mailboxId;
      json[r'websocket_url'] = this.websocketUrl;
    return json;
  }

  /// Returns a new [EmailSubscription] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailSubscription? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'), 'Required key "EmailSubscription[token]" is missing from JSON.');
        assert(json[r'token'] != null, 'Required key "EmailSubscription[token]" has a null value in JSON.');
        assert(json.containsKey(r'expires_in'), 'Required key "EmailSubscription[expires_in]" is missing from JSON.');
        assert(json[r'expires_in'] != null, 'Required key "EmailSubscription[expires_in]" has a null value in JSON.');
        assert(json.containsKey(r'channel'), 'Required key "EmailSubscription[channel]" is missing from JSON.');
        assert(json[r'channel'] != null, 'Required key "EmailSubscription[channel]" has a null value in JSON.');
        assert(json.containsKey(r'account_id'), 'Required key "EmailSubscription[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "EmailSubscription[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'mailbox_id'), 'Required key "EmailSubscription[mailbox_id]" is missing from JSON.');
        assert(json[r'mailbox_id'] != null, 'Required key "EmailSubscription[mailbox_id]" has a null value in JSON.');
        assert(json.containsKey(r'websocket_url'), 'Required key "EmailSubscription[websocket_url]" is missing from JSON.');
        assert(json[r'websocket_url'] != null, 'Required key "EmailSubscription[websocket_url]" has a null value in JSON.');
        return true;
      }());

      return EmailSubscription(
        token: mapValueOfType<String>(json, r'token')!,
        expiresIn: EmailSubscriptionExpiresInEnum.fromJson(json[r'expires_in'])!,
        channel: EmailSubscriptionChannelEnum.fromJson(json[r'channel'])!,
        accountId: mapValueOfType<String>(json, r'account_id')!,
        mailboxId: mapValueOfType<String>(json, r'mailbox_id')!,
        websocketUrl: mapValueOfType<String>(json, r'websocket_url')!,
      );
    }
    return null;
  }

  static List<EmailSubscription> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSubscription>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSubscription.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailSubscription> mapFromJson(dynamic json) {
    final map = <String, EmailSubscription>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailSubscription.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailSubscription-objects as value to a dart map
  static Map<String, List<EmailSubscription>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailSubscription>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailSubscription.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
    'expires_in',
    'channel',
    'account_id',
    'mailbox_id',
    'websocket_url',
  };
}


enum EmailSubscriptionExpiresInEnum {
  number60._(60),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailSubscriptionExpiresInEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [EmailSubscriptionExpiresInEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailSubscriptionExpiresInEnum? fromJson(dynamic value) => EmailSubscriptionExpiresInEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailSubscriptionExpiresInEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailSubscriptionExpiresInEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSubscriptionExpiresInEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSubscriptionExpiresInEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailSubscriptionExpiresInEnum] to int,
/// and [decode] dynamic data back to [EmailSubscriptionExpiresInEnum].
class EmailSubscriptionExpiresInEnumTypeTransformer {
  factory EmailSubscriptionExpiresInEnumTypeTransformer() => _instance ??= const EmailSubscriptionExpiresInEnumTypeTransformer._();

  const EmailSubscriptionExpiresInEnumTypeTransformer._();

  int encode(EmailSubscriptionExpiresInEnum data) => data._value;

  /// Returns the instance of [EmailSubscriptionExpiresInEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailSubscriptionExpiresInEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailSubscriptionExpiresInEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 60: return EmailSubscriptionExpiresInEnum.number60;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailSubscriptionExpiresInEnumTypeTransformer? _instance;
}



enum EmailSubscriptionChannelEnum {
  emailReceivedChannel._(r'EmailReceivedChannel'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailSubscriptionChannelEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailSubscriptionChannelEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailSubscriptionChannelEnum? fromJson(dynamic value) => EmailSubscriptionChannelEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailSubscriptionChannelEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailSubscriptionChannelEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSubscriptionChannelEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSubscriptionChannelEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailSubscriptionChannelEnum] to String,
/// and [decode] dynamic data back to [EmailSubscriptionChannelEnum].
class EmailSubscriptionChannelEnumTypeTransformer {
  factory EmailSubscriptionChannelEnumTypeTransformer() => _instance ??= const EmailSubscriptionChannelEnumTypeTransformer._();

  const EmailSubscriptionChannelEnumTypeTransformer._();

  String encode(EmailSubscriptionChannelEnum data) => data._value;

  /// Returns the instance of [EmailSubscriptionChannelEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailSubscriptionChannelEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailSubscriptionChannelEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'EmailReceivedChannel': return EmailSubscriptionChannelEnum.emailReceivedChannel;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailSubscriptionChannelEnumTypeTransformer? _instance;
}



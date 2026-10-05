//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetEmailSubscription200ResponseDataSubscription {
  /// Returns a new [GetEmailSubscription200ResponseDataSubscription] instance.
  GetEmailSubscription200ResponseDataSubscription({
    required this.token,
    required this.expiresIn,
    required this.channel,
    required this.accountId,
    required this.mailboxId,
    required this.websocketUrl,
  });

  String token;

  GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum expiresIn;

  GetEmailSubscription200ResponseDataSubscriptionChannelEnum channel;

  String accountId;

  String mailboxId;

  /// Base WebSocket endpoint. Append email_subscription_token as a query parameter.
  String websocketUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetEmailSubscription200ResponseDataSubscription &&
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
  String toString() => 'GetEmailSubscription200ResponseDataSubscription[token=$token, expiresIn=$expiresIn, channel=$channel, accountId=$accountId, mailboxId=$mailboxId, websocketUrl=$websocketUrl]';

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

  /// Returns a new [GetEmailSubscription200ResponseDataSubscription] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetEmailSubscription200ResponseDataSubscription? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'), 'Required key "GetEmailSubscription200ResponseDataSubscription[token]" is missing from JSON.');
        assert(json[r'token'] != null, 'Required key "GetEmailSubscription200ResponseDataSubscription[token]" has a null value in JSON.');
        assert(json.containsKey(r'expires_in'), 'Required key "GetEmailSubscription200ResponseDataSubscription[expires_in]" is missing from JSON.');
        assert(json[r'expires_in'] != null, 'Required key "GetEmailSubscription200ResponseDataSubscription[expires_in]" has a null value in JSON.');
        assert(json.containsKey(r'channel'), 'Required key "GetEmailSubscription200ResponseDataSubscription[channel]" is missing from JSON.');
        assert(json[r'channel'] != null, 'Required key "GetEmailSubscription200ResponseDataSubscription[channel]" has a null value in JSON.');
        assert(json.containsKey(r'account_id'), 'Required key "GetEmailSubscription200ResponseDataSubscription[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "GetEmailSubscription200ResponseDataSubscription[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'mailbox_id'), 'Required key "GetEmailSubscription200ResponseDataSubscription[mailbox_id]" is missing from JSON.');
        assert(json[r'mailbox_id'] != null, 'Required key "GetEmailSubscription200ResponseDataSubscription[mailbox_id]" has a null value in JSON.');
        assert(json.containsKey(r'websocket_url'), 'Required key "GetEmailSubscription200ResponseDataSubscription[websocket_url]" is missing from JSON.');
        assert(json[r'websocket_url'] != null, 'Required key "GetEmailSubscription200ResponseDataSubscription[websocket_url]" has a null value in JSON.');
        return true;
      }());

      return GetEmailSubscription200ResponseDataSubscription(
        token: mapValueOfType<String>(json, r'token')!,
        expiresIn: GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum.fromJson(json[r'expires_in'])!,
        channel: GetEmailSubscription200ResponseDataSubscriptionChannelEnum.fromJson(json[r'channel'])!,
        accountId: mapValueOfType<String>(json, r'account_id')!,
        mailboxId: mapValueOfType<String>(json, r'mailbox_id')!,
        websocketUrl: mapValueOfType<String>(json, r'websocket_url')!,
      );
    }
    return null;
  }

  static List<GetEmailSubscription200ResponseDataSubscription> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailSubscription200ResponseDataSubscription>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailSubscription200ResponseDataSubscription.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetEmailSubscription200ResponseDataSubscription> mapFromJson(dynamic json) {
    final map = <String, GetEmailSubscription200ResponseDataSubscription>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetEmailSubscription200ResponseDataSubscription.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetEmailSubscription200ResponseDataSubscription-objects as value to a dart map
  static Map<String, List<GetEmailSubscription200ResponseDataSubscription>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetEmailSubscription200ResponseDataSubscription>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetEmailSubscription200ResponseDataSubscription.listFromJson(entry.value, growable: growable,);
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


enum GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum {
  number60._(60),
  ;

  /// Instantiate a new enum with the provided value.
  const GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum? fromJson(dynamic value) => GetEmailSubscription200ResponseDataSubscriptionExpiresInEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum] to int,
/// and [decode] dynamic data back to [GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum].
class GetEmailSubscription200ResponseDataSubscriptionExpiresInEnumTypeTransformer {
  factory GetEmailSubscription200ResponseDataSubscriptionExpiresInEnumTypeTransformer() => _instance ??= const GetEmailSubscription200ResponseDataSubscriptionExpiresInEnumTypeTransformer._();

  const GetEmailSubscription200ResponseDataSubscriptionExpiresInEnumTypeTransformer._();

  int encode(GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum data) => data._value;

  /// Returns the instance of [GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 60: return GetEmailSubscription200ResponseDataSubscriptionExpiresInEnum.number60;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static GetEmailSubscription200ResponseDataSubscriptionExpiresInEnumTypeTransformer? _instance;
}



enum GetEmailSubscription200ResponseDataSubscriptionChannelEnum {
  emailReceivedChannel._(r'EmailReceivedChannel'),
  ;

  /// Instantiate a new enum with the provided value.
  const GetEmailSubscription200ResponseDataSubscriptionChannelEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [GetEmailSubscription200ResponseDataSubscriptionChannelEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static GetEmailSubscription200ResponseDataSubscriptionChannelEnum? fromJson(dynamic value) => GetEmailSubscription200ResponseDataSubscriptionChannelEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [GetEmailSubscription200ResponseDataSubscriptionChannelEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<GetEmailSubscription200ResponseDataSubscriptionChannelEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailSubscription200ResponseDataSubscriptionChannelEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailSubscription200ResponseDataSubscriptionChannelEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [GetEmailSubscription200ResponseDataSubscriptionChannelEnum] to String,
/// and [decode] dynamic data back to [GetEmailSubscription200ResponseDataSubscriptionChannelEnum].
class GetEmailSubscription200ResponseDataSubscriptionChannelEnumTypeTransformer {
  factory GetEmailSubscription200ResponseDataSubscriptionChannelEnumTypeTransformer() => _instance ??= const GetEmailSubscription200ResponseDataSubscriptionChannelEnumTypeTransformer._();

  const GetEmailSubscription200ResponseDataSubscriptionChannelEnumTypeTransformer._();

  String encode(GetEmailSubscription200ResponseDataSubscriptionChannelEnum data) => data._value;

  /// Returns the instance of [GetEmailSubscription200ResponseDataSubscriptionChannelEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  GetEmailSubscription200ResponseDataSubscriptionChannelEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is GetEmailSubscription200ResponseDataSubscriptionChannelEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'EmailReceivedChannel': return GetEmailSubscription200ResponseDataSubscriptionChannelEnum.emailReceivedChannel;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static GetEmailSubscription200ResponseDataSubscriptionChannelEnumTypeTransformer? _instance;
}



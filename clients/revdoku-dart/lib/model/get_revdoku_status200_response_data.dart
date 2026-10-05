//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetRevdokuStatus200ResponseData {
  /// Returns a new [GetRevdokuStatus200ResponseData] instance.
  GetRevdokuStatus200ResponseData({
    this.account,
    this.defaultAccountId,
    this.accounts = const [],
    this.features,
    this.connected,
    this.serverVersion,
    this.clientVersion,
    this.connection,
    this.limits = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountIdentity? account;

  String? defaultAccountId;

  List<AccountIdentity> accounts;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  GetRevdokuStatus200ResponseDataFeatures? features;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? connected;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serverVersion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientVersion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  GetRevdokuStatus200ResponseDataConnection? connection;

  Map<String, Object?>? limits;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetRevdokuStatus200ResponseData &&
    other.account == account &&
    other.defaultAccountId == defaultAccountId &&
    _deepEquality.equals(other.accounts, accounts) &&
    other.features == features &&
    other.connected == connected &&
    other.serverVersion == serverVersion &&
    other.clientVersion == clientVersion &&
    other.connection == connection &&
    _deepEquality.equals(other.limits, limits);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (account == null ? 0 : account!.hashCode) +
    (defaultAccountId == null ? 0 : defaultAccountId!.hashCode) +
    (accounts.hashCode) +
    (features == null ? 0 : features!.hashCode) +
    (connected == null ? 0 : connected!.hashCode) +
    (serverVersion == null ? 0 : serverVersion!.hashCode) +
    (clientVersion == null ? 0 : clientVersion!.hashCode) +
    (connection == null ? 0 : connection!.hashCode) +
    (limits == null ? 0 : limits!.hashCode);

  @override
  String toString() => 'GetRevdokuStatus200ResponseData[account=$account, defaultAccountId=$defaultAccountId, accounts=$accounts, features=$features, connected=$connected, serverVersion=$serverVersion, clientVersion=$clientVersion, connection=$connection, limits=$limits]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.account != null) {
      json[r'account'] = this.account;
    }
    if (this.defaultAccountId != null) {
      json[r'default_account_id'] = this.defaultAccountId;
    } else {
      json[r'default_account_id'] = null;
    }
      json[r'accounts'] = this.accounts;
    if (this.features != null) {
      json[r'features'] = this.features;
    }
    if (this.connected != null) {
      json[r'connected'] = this.connected;
    }
    if (this.serverVersion != null) {
      json[r'server_version'] = this.serverVersion;
    }
    if (this.clientVersion != null) {
      json[r'client_version'] = this.clientVersion;
    }
    if (this.connection != null) {
      json[r'connection'] = this.connection;
    }
    if (this.limits != null) {
      json[r'limits'] = this.limits;
    } else {
      json[r'limits'] = null;
    }
    return json;
  }

  /// Returns a new [GetRevdokuStatus200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetRevdokuStatus200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return GetRevdokuStatus200ResponseData(
        account: AccountIdentity.fromJson(json[r'account']),
        defaultAccountId: mapValueOfType<String>(json, r'default_account_id'),
        accounts: AccountIdentity.listFromJson(json[r'accounts']),
        features: GetRevdokuStatus200ResponseDataFeatures.fromJson(json[r'features']),
        connected: mapValueOfType<bool>(json, r'connected'),
        serverVersion: mapValueOfType<String>(json, r'server_version'),
        clientVersion: mapValueOfType<String>(json, r'client_version'),
        connection: GetRevdokuStatus200ResponseDataConnection.fromJson(json[r'connection']),
        limits: mapCastOfType<String, Object?>(json, r'limits') ?? const {},
      );
    }
    return null;
  }

  static List<GetRevdokuStatus200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetRevdokuStatus200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetRevdokuStatus200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetRevdokuStatus200ResponseData> mapFromJson(dynamic json) {
    final map = <String, GetRevdokuStatus200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetRevdokuStatus200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetRevdokuStatus200ResponseData-objects as value to a dart map
  static Map<String, List<GetRevdokuStatus200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetRevdokuStatus200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetRevdokuStatus200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


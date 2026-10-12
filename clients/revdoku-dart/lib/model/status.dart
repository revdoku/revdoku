//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class Status {
  /// Returns a new [Status] instance.
  Status({
    required this.connected,
    this.account = const {},
    this.defaultAccountId,
    this.accounts = const [],
    this.serverVersion,
    this.clientVersion,
    this.features,
    required this.connection,
    this.user,
    this.dashboardUrl,
  });

  bool connected;

  /// Selected account identity and state.
  Map<String, Object?> account;

  String? defaultAccountId;

  List<Map<String, Object?>> accounts;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serverVersion;

  /// Current CLI and skill release.
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
  StatusFeatures? features;

  Connection connection;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  StatusUser? user;

  /// Dashboard link for the selected account. It grants no access.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? dashboardUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Status &&
    other.connected == connected &&
    _deepEquality.equals(other.account, account) &&
    other.defaultAccountId == defaultAccountId &&
    _deepEquality.equals(other.accounts, accounts) &&
    other.serverVersion == serverVersion &&
    other.clientVersion == clientVersion &&
    other.features == features &&
    other.connection == connection &&
    other.user == user &&
    other.dashboardUrl == dashboardUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (connected.hashCode) +
    (account.hashCode) +
    (defaultAccountId == null ? 0 : defaultAccountId!.hashCode) +
    (accounts.hashCode) +
    (serverVersion == null ? 0 : serverVersion!.hashCode) +
    (clientVersion == null ? 0 : clientVersion!.hashCode) +
    (features == null ? 0 : features!.hashCode) +
    (connection.hashCode) +
    (user == null ? 0 : user!.hashCode) +
    (dashboardUrl == null ? 0 : dashboardUrl!.hashCode);

  @override
  String toString() => 'Status[connected=$connected, account=$account, defaultAccountId=$defaultAccountId, accounts=$accounts, serverVersion=$serverVersion, clientVersion=$clientVersion, features=$features, connection=$connection, user=$user, dashboardUrl=$dashboardUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'connected'] = this.connected;
      json[r'account'] = this.account;
    if (this.defaultAccountId != null) {
      json[r'default_account_id'] = this.defaultAccountId;
    } else {
      json[r'default_account_id'] = null;
    }
      json[r'accounts'] = this.accounts;
    if (this.serverVersion != null) {
      json[r'server_version'] = this.serverVersion;
    }
    if (this.clientVersion != null) {
      json[r'client_version'] = this.clientVersion;
    }
    if (this.features != null) {
      json[r'features'] = this.features;
    }
      json[r'connection'] = this.connection;
    if (this.user != null) {
      json[r'user'] = this.user;
    }
    if (this.dashboardUrl != null) {
      json[r'dashboard_url'] = this.dashboardUrl;
    }
    return json;
  }

  /// Returns a new [Status] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Status? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'connected'), 'Required key "Status[connected]" is missing from JSON.');
        assert(json[r'connected'] != null, 'Required key "Status[connected]" has a null value in JSON.');
        assert(json.containsKey(r'account'), 'Required key "Status[account]" is missing from JSON.');
        assert(json[r'account'] != null, 'Required key "Status[account]" has a null value in JSON.');
        assert(json.containsKey(r'connection'), 'Required key "Status[connection]" is missing from JSON.');
        assert(json[r'connection'] != null, 'Required key "Status[connection]" has a null value in JSON.');
        return true;
      }());

      return Status(
        connected: mapValueOfType<bool>(json, r'connected')!,
        account: mapCastOfType<String, Object?>(json, r'account')!,
        defaultAccountId: mapValueOfType<String>(json, r'default_account_id'),
        accounts: Map.listFromJson(json[r'accounts']),
        serverVersion: mapValueOfType<String>(json, r'server_version'),
        clientVersion: mapValueOfType<String>(json, r'client_version'),
        features: StatusFeatures.fromJson(json[r'features']),
        connection: Connection.fromJson(json[r'connection'])!,
        user: StatusUser.fromJson(json[r'user']),
        dashboardUrl: mapValueOfType<String>(json, r'dashboard_url'),
      );
    }
    return null;
  }

  static List<Status> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Status>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Status.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Status> mapFromJson(dynamic json) {
    final map = <String, Status>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Status.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Status-objects as value to a dart map
  static Map<String, List<Status>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Status>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Status.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'connected',
    'account',
    'connection',
  };
}


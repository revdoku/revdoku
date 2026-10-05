//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ApiErrorError {
  /// Returns a new [ApiErrorError] instance.
  ApiErrorError({
    required this.code,
    required this.message,
    this.details,
    this.requestId,
    this.docsUrl,
    this.timestamp,
    this.recoverable,
    this.nextAction,
    this.browserUrl,
  });

  String code;

  String message;

  /// Structured error details: an object or an array of field/message validation errors.
  Object? details;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? requestId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? docsUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timestamp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? recoverable;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nextAction;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? browserUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiErrorError &&
    other.code == code &&
    other.message == message &&
    other.details == details &&
    other.requestId == requestId &&
    other.docsUrl == docsUrl &&
    other.timestamp == timestamp &&
    other.recoverable == recoverable &&
    other.nextAction == nextAction &&
    other.browserUrl == browserUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (code.hashCode) +
    (message.hashCode) +
    (details == null ? 0 : details!.hashCode) +
    (requestId == null ? 0 : requestId!.hashCode) +
    (docsUrl == null ? 0 : docsUrl!.hashCode) +
    (timestamp == null ? 0 : timestamp!.hashCode) +
    (recoverable == null ? 0 : recoverable!.hashCode) +
    (nextAction == null ? 0 : nextAction!.hashCode) +
    (browserUrl == null ? 0 : browserUrl!.hashCode);

  @override
  String toString() => 'ApiErrorError[code=$code, message=$message, details=$details, requestId=$requestId, docsUrl=$docsUrl, timestamp=$timestamp, recoverable=$recoverable, nextAction=$nextAction, browserUrl=$browserUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'code'] = this.code;
      json[r'message'] = this.message;
    if (this.details != null) {
      json[r'details'] = this.details;
    } else {
      json[r'details'] = null;
    }
    if (this.requestId != null) {
      json[r'request_id'] = this.requestId;
    } else {
      json[r'request_id'] = null;
    }
    if (this.docsUrl != null) {
      json[r'docs_url'] = this.docsUrl;
    } else {
      json[r'docs_url'] = null;
    }
    if (this.timestamp != null) {
      json[r'timestamp'] = this.timestamp!.toUtc().toIso8601String();
    } else {
      json[r'timestamp'] = null;
    }
    if (this.recoverable != null) {
      json[r'recoverable'] = this.recoverable;
    } else {
      json[r'recoverable'] = null;
    }
    if (this.nextAction != null) {
      json[r'next_action'] = this.nextAction;
    } else {
      json[r'next_action'] = null;
    }
    if (this.browserUrl != null) {
      json[r'browser_url'] = this.browserUrl;
    } else {
      json[r'browser_url'] = null;
    }
    return json;
  }

  /// Returns a new [ApiErrorError] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiErrorError? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'code'), 'Required key "ApiErrorError[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "ApiErrorError[code]" has a null value in JSON.');
        assert(json.containsKey(r'message'), 'Required key "ApiErrorError[message]" is missing from JSON.');
        assert(json[r'message'] != null, 'Required key "ApiErrorError[message]" has a null value in JSON.');
        return true;
      }());

      return ApiErrorError(
        code: mapValueOfType<String>(json, r'code')!,
        message: mapValueOfType<String>(json, r'message')!,
        details: mapValueOfType<Object>(json, r'details'),
        requestId: mapValueOfType<String>(json, r'request_id'),
        docsUrl: mapValueOfType<String>(json, r'docs_url'),
        timestamp: mapDateTime(json, r'timestamp', r''),
        recoverable: mapValueOfType<bool>(json, r'recoverable'),
        nextAction: mapValueOfType<String>(json, r'next_action'),
        browserUrl: mapValueOfType<String>(json, r'browser_url'),
      );
    }
    return null;
  }

  static List<ApiErrorError> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiErrorError>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiErrorError.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiErrorError> mapFromJson(dynamic json) {
    final map = <String, ApiErrorError>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiErrorError.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiErrorError-objects as value to a dart map
  static Map<String, List<ApiErrorError>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiErrorError>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiErrorError.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'code',
    'message',
  };
}


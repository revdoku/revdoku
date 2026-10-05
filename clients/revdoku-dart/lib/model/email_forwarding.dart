//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailForwarding {
  /// Returns a new [EmailForwarding] instance.
  EmailForwarding({
    required this.method,
    required this.memberId,
    required this.memberEmail,
    required this.intakeAccountId,
    this.outerFrom,
    this.outerSubject,
    this.outerMessageId,
    this.originalDateRaw,
    this.originalSentAt,
    required this.attribution,
    required this.parserVersion,
  });

  String method;

  String memberId;

  String memberEmail;

  String intakeAccountId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? outerFrom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? outerSubject;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? outerMessageId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? originalDateRaw;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? originalSentAt;

  EmailForwardingAttributionEnum attribution;

  /// Parser implementation used at intake; does not change the forwarding response shape.
  ///
  /// Minimum value: 1
  int parserVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailForwarding &&
    other.method == method &&
    other.memberId == memberId &&
    other.memberEmail == memberEmail &&
    other.intakeAccountId == intakeAccountId &&
    other.outerFrom == outerFrom &&
    other.outerSubject == outerSubject &&
    other.outerMessageId == outerMessageId &&
    other.originalDateRaw == originalDateRaw &&
    other.originalSentAt == originalSentAt &&
    other.attribution == attribution &&
    other.parserVersion == parserVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (method.hashCode) +
    (memberId.hashCode) +
    (memberEmail.hashCode) +
    (intakeAccountId.hashCode) +
    (outerFrom == null ? 0 : outerFrom!.hashCode) +
    (outerSubject == null ? 0 : outerSubject!.hashCode) +
    (outerMessageId == null ? 0 : outerMessageId!.hashCode) +
    (originalDateRaw == null ? 0 : originalDateRaw!.hashCode) +
    (originalSentAt == null ? 0 : originalSentAt!.hashCode) +
    (attribution.hashCode) +
    (parserVersion.hashCode);

  @override
  String toString() => 'EmailForwarding[method=$method, memberId=$memberId, memberEmail=$memberEmail, intakeAccountId=$intakeAccountId, outerFrom=$outerFrom, outerSubject=$outerSubject, outerMessageId=$outerMessageId, originalDateRaw=$originalDateRaw, originalSentAt=$originalSentAt, attribution=$attribution, parserVersion=$parserVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'method'] = this.method;
      json[r'member_id'] = this.memberId;
      json[r'member_email'] = this.memberEmail;
      json[r'intake_account_id'] = this.intakeAccountId;
    if (this.outerFrom != null) {
      json[r'outer_from'] = this.outerFrom;
    } else {
      json[r'outer_from'] = null;
    }
    if (this.outerSubject != null) {
      json[r'outer_subject'] = this.outerSubject;
    } else {
      json[r'outer_subject'] = null;
    }
    if (this.outerMessageId != null) {
      json[r'outer_message_id'] = this.outerMessageId;
    } else {
      json[r'outer_message_id'] = null;
    }
    if (this.originalDateRaw != null) {
      json[r'original_date_raw'] = this.originalDateRaw;
    } else {
      json[r'original_date_raw'] = null;
    }
    if (this.originalSentAt != null) {
      json[r'original_sent_at'] = this.originalSentAt;
    } else {
      json[r'original_sent_at'] = null;
    }
      json[r'attribution'] = this.attribution;
      json[r'parser_version'] = this.parserVersion;
    return json;
  }

  /// Returns a new [EmailForwarding] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailForwarding? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'method'), 'Required key "EmailForwarding[method]" is missing from JSON.');
        assert(json[r'method'] != null, 'Required key "EmailForwarding[method]" has a null value in JSON.');
        assert(json.containsKey(r'member_id'), 'Required key "EmailForwarding[member_id]" is missing from JSON.');
        assert(json[r'member_id'] != null, 'Required key "EmailForwarding[member_id]" has a null value in JSON.');
        assert(json.containsKey(r'member_email'), 'Required key "EmailForwarding[member_email]" is missing from JSON.');
        assert(json[r'member_email'] != null, 'Required key "EmailForwarding[member_email]" has a null value in JSON.');
        assert(json.containsKey(r'intake_account_id'), 'Required key "EmailForwarding[intake_account_id]" is missing from JSON.');
        assert(json[r'intake_account_id'] != null, 'Required key "EmailForwarding[intake_account_id]" has a null value in JSON.');
        assert(json.containsKey(r'attribution'), 'Required key "EmailForwarding[attribution]" is missing from JSON.');
        assert(json[r'attribution'] != null, 'Required key "EmailForwarding[attribution]" has a null value in JSON.');
        assert(json.containsKey(r'parser_version'), 'Required key "EmailForwarding[parser_version]" is missing from JSON.');
        assert(json[r'parser_version'] != null, 'Required key "EmailForwarding[parser_version]" has a null value in JSON.');
        return true;
      }());

      return EmailForwarding(
        method: mapValueOfType<String>(json, r'method')!,
        memberId: mapValueOfType<String>(json, r'member_id')!,
        memberEmail: mapValueOfType<String>(json, r'member_email')!,
        intakeAccountId: mapValueOfType<String>(json, r'intake_account_id')!,
        outerFrom: mapValueOfType<String>(json, r'outer_from'),
        outerSubject: mapValueOfType<String>(json, r'outer_subject'),
        outerMessageId: mapValueOfType<String>(json, r'outer_message_id'),
        originalDateRaw: mapValueOfType<String>(json, r'original_date_raw'),
        originalSentAt: mapValueOfType<String>(json, r'original_sent_at'),
        attribution: EmailForwardingAttributionEnum.fromJson(json[r'attribution'])!,
        parserVersion: mapValueOfType<int>(json, r'parser_version')!,
      );
    }
    return null;
  }

  static List<EmailForwarding> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailForwarding>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailForwarding.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailForwarding> mapFromJson(dynamic json) {
    final map = <String, EmailForwarding>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailForwarding.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailForwarding-objects as value to a dart map
  static Map<String, List<EmailForwarding>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailForwarding>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailForwarding.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'method',
    'member_id',
    'member_email',
    'intake_account_id',
    'attribution',
    'parser_version',
  };
}


enum EmailForwardingAttributionEnum {
  memberForwarded._(r'member_forwarded'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailForwardingAttributionEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailForwardingAttributionEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailForwardingAttributionEnum? fromJson(dynamic value) => EmailForwardingAttributionEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailForwardingAttributionEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailForwardingAttributionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailForwardingAttributionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailForwardingAttributionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailForwardingAttributionEnum] to String,
/// and [decode] dynamic data back to [EmailForwardingAttributionEnum].
class EmailForwardingAttributionEnumTypeTransformer {
  factory EmailForwardingAttributionEnumTypeTransformer() => _instance ??= const EmailForwardingAttributionEnumTypeTransformer._();

  const EmailForwardingAttributionEnumTypeTransformer._();

  String encode(EmailForwardingAttributionEnum data) => data._value;

  /// Returns the instance of [EmailForwardingAttributionEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailForwardingAttributionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailForwardingAttributionEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'member_forwarded': return EmailForwardingAttributionEnum.memberForwarded;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailForwardingAttributionEnumTypeTransformer? _instance;
}



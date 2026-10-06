//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailUsage {
  /// Returns a new [EmailUsage] instance.
  EmailUsage({
    this.used,
    this.monthlyLimit,
    this.remaining,
    this.bytesUsed,
    this.monthlyBytesLimit,
    this.bytesRemaining,
    this.maxMessageBytes,
    this.resetsAt,
    this.paused,
    this.pauseReason,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? used;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? monthlyLimit;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? remaining;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? bytesUsed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? monthlyBytesLimit;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? bytesRemaining;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? maxMessageBytes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? resetsAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? paused;

  String? pauseReason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailUsage &&
    other.used == used &&
    other.monthlyLimit == monthlyLimit &&
    other.remaining == remaining &&
    other.bytesUsed == bytesUsed &&
    other.monthlyBytesLimit == monthlyBytesLimit &&
    other.bytesRemaining == bytesRemaining &&
    other.maxMessageBytes == maxMessageBytes &&
    other.resetsAt == resetsAt &&
    other.paused == paused &&
    other.pauseReason == pauseReason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (used == null ? 0 : used!.hashCode) +
    (monthlyLimit == null ? 0 : monthlyLimit!.hashCode) +
    (remaining == null ? 0 : remaining!.hashCode) +
    (bytesUsed == null ? 0 : bytesUsed!.hashCode) +
    (monthlyBytesLimit == null ? 0 : monthlyBytesLimit!.hashCode) +
    (bytesRemaining == null ? 0 : bytesRemaining!.hashCode) +
    (maxMessageBytes == null ? 0 : maxMessageBytes!.hashCode) +
    (resetsAt == null ? 0 : resetsAt!.hashCode) +
    (paused == null ? 0 : paused!.hashCode) +
    (pauseReason == null ? 0 : pauseReason!.hashCode);

  @override
  String toString() => 'EmailUsage[used=$used, monthlyLimit=$monthlyLimit, remaining=$remaining, bytesUsed=$bytesUsed, monthlyBytesLimit=$monthlyBytesLimit, bytesRemaining=$bytesRemaining, maxMessageBytes=$maxMessageBytes, resetsAt=$resetsAt, paused=$paused, pauseReason=$pauseReason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.used != null) {
      json[r'used'] = this.used;
    }
    if (this.monthlyLimit != null) {
      json[r'monthly_limit'] = this.monthlyLimit;
    }
    if (this.remaining != null) {
      json[r'remaining'] = this.remaining;
    }
    if (this.bytesUsed != null) {
      json[r'bytes_used'] = this.bytesUsed;
    }
    if (this.monthlyBytesLimit != null) {
      json[r'monthly_bytes_limit'] = this.monthlyBytesLimit;
    }
    if (this.bytesRemaining != null) {
      json[r'bytes_remaining'] = this.bytesRemaining;
    }
    if (this.maxMessageBytes != null) {
      json[r'max_message_bytes'] = this.maxMessageBytes;
    }
    if (this.resetsAt != null) {
      json[r'resets_at'] = this.resetsAt!.toUtc().toIso8601String();
    }
    if (this.paused != null) {
      json[r'paused'] = this.paused;
    }
    if (this.pauseReason != null) {
      json[r'pause_reason'] = this.pauseReason;
    } else {
      json[r'pause_reason'] = null;
    }
    return json;
  }

  /// Returns a new [EmailUsage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailUsage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return EmailUsage(
        used: mapValueOfType<int>(json, r'used'),
        monthlyLimit: mapValueOfType<int>(json, r'monthly_limit'),
        remaining: mapValueOfType<int>(json, r'remaining'),
        bytesUsed: mapValueOfType<int>(json, r'bytes_used'),
        monthlyBytesLimit: mapValueOfType<int>(json, r'monthly_bytes_limit'),
        bytesRemaining: mapValueOfType<int>(json, r'bytes_remaining'),
        maxMessageBytes: mapValueOfType<int>(json, r'max_message_bytes'),
        resetsAt: mapDateTime(json, r'resets_at', r''),
        paused: mapValueOfType<bool>(json, r'paused'),
        pauseReason: mapValueOfType<String>(json, r'pause_reason'),
      );
    }
    return null;
  }

  static List<EmailUsage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailUsage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailUsage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailUsage> mapFromJson(dynamic json) {
    final map = <String, EmailUsage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailUsage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailUsage-objects as value to a dart map
  static Map<String, List<EmailUsage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailUsage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailUsage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


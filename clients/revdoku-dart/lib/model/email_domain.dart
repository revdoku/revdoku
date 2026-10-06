//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDomain {
  /// Returns a new [EmailDomain] instance.
  EmailDomain({
    this.suggestedSubdomain,
    this.rootGuidance,
    this.pauseReason,
    required this.id,
    required this.hostname,
    required this.status,
    this.guidance,
    this.receiving,
    this.rootDomain,
    this.pausedAt,
    this.lastCheckedAt,
    this.ownershipVerifiedAt,
    this.setupExpiresAt,
    this.readyAt,
    this.requiredDnsRecords = const [],
    this.error,
    this.assignedMailboxes = const [],
  });

  String? suggestedSubdomain;

  String? rootGuidance;

  String? pauseReason;

  String id;

  String hostname;

  String status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? guidance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? receiving;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? rootDomain;

  DateTime? pausedAt;

  DateTime? lastCheckedAt;

  DateTime? ownershipVerifiedAt;

  DateTime? setupExpiresAt;

  DateTime? readyAt;

  List<DnsRecord> requiredDnsRecords;

  EmailDomainError? error;

  List<EmailDomainAssignedMailboxesInner> assignedMailboxes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDomain &&
    other.suggestedSubdomain == suggestedSubdomain &&
    other.rootGuidance == rootGuidance &&
    other.pauseReason == pauseReason &&
    other.id == id &&
    other.hostname == hostname &&
    other.status == status &&
    other.guidance == guidance &&
    other.receiving == receiving &&
    other.rootDomain == rootDomain &&
    other.pausedAt == pausedAt &&
    other.lastCheckedAt == lastCheckedAt &&
    other.ownershipVerifiedAt == ownershipVerifiedAt &&
    other.setupExpiresAt == setupExpiresAt &&
    other.readyAt == readyAt &&
    _deepEquality.equals(other.requiredDnsRecords, requiredDnsRecords) &&
    other.error == error &&
    _deepEquality.equals(other.assignedMailboxes, assignedMailboxes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (suggestedSubdomain == null ? 0 : suggestedSubdomain!.hashCode) +
    (rootGuidance == null ? 0 : rootGuidance!.hashCode) +
    (pauseReason == null ? 0 : pauseReason!.hashCode) +
    (id.hashCode) +
    (hostname.hashCode) +
    (status.hashCode) +
    (guidance == null ? 0 : guidance!.hashCode) +
    (receiving == null ? 0 : receiving!.hashCode) +
    (rootDomain == null ? 0 : rootDomain!.hashCode) +
    (pausedAt == null ? 0 : pausedAt!.hashCode) +
    (lastCheckedAt == null ? 0 : lastCheckedAt!.hashCode) +
    (ownershipVerifiedAt == null ? 0 : ownershipVerifiedAt!.hashCode) +
    (setupExpiresAt == null ? 0 : setupExpiresAt!.hashCode) +
    (readyAt == null ? 0 : readyAt!.hashCode) +
    (requiredDnsRecords.hashCode) +
    (error == null ? 0 : error!.hashCode) +
    (assignedMailboxes.hashCode);

  @override
  String toString() => 'EmailDomain[suggestedSubdomain=$suggestedSubdomain, rootGuidance=$rootGuidance, pauseReason=$pauseReason, id=$id, hostname=$hostname, status=$status, guidance=$guidance, receiving=$receiving, rootDomain=$rootDomain, pausedAt=$pausedAt, lastCheckedAt=$lastCheckedAt, ownershipVerifiedAt=$ownershipVerifiedAt, setupExpiresAt=$setupExpiresAt, readyAt=$readyAt, requiredDnsRecords=$requiredDnsRecords, error=$error, assignedMailboxes=$assignedMailboxes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.suggestedSubdomain != null) {
      json[r'suggested_subdomain'] = this.suggestedSubdomain;
    } else {
      json[r'suggested_subdomain'] = null;
    }
    if (this.rootGuidance != null) {
      json[r'root_guidance'] = this.rootGuidance;
    } else {
      json[r'root_guidance'] = null;
    }
    if (this.pauseReason != null) {
      json[r'pause_reason'] = this.pauseReason;
    } else {
      json[r'pause_reason'] = null;
    }
      json[r'id'] = this.id;
      json[r'hostname'] = this.hostname;
      json[r'status'] = this.status;
    if (this.guidance != null) {
      json[r'guidance'] = this.guidance;
    }
    if (this.receiving != null) {
      json[r'receiving'] = this.receiving;
    }
    if (this.rootDomain != null) {
      json[r'root_domain'] = this.rootDomain;
    }
    if (this.pausedAt != null) {
      json[r'paused_at'] = this.pausedAt!.toUtc().toIso8601String();
    } else {
      json[r'paused_at'] = null;
    }
    if (this.lastCheckedAt != null) {
      json[r'last_checked_at'] = this.lastCheckedAt!.toUtc().toIso8601String();
    } else {
      json[r'last_checked_at'] = null;
    }
    if (this.ownershipVerifiedAt != null) {
      json[r'ownership_verified_at'] = this.ownershipVerifiedAt!.toUtc().toIso8601String();
    } else {
      json[r'ownership_verified_at'] = null;
    }
    if (this.setupExpiresAt != null) {
      json[r'setup_expires_at'] = this.setupExpiresAt!.toUtc().toIso8601String();
    } else {
      json[r'setup_expires_at'] = null;
    }
    if (this.readyAt != null) {
      json[r'ready_at'] = this.readyAt!.toUtc().toIso8601String();
    } else {
      json[r'ready_at'] = null;
    }
      json[r'required_dns_records'] = this.requiredDnsRecords;
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
      json[r'assigned_mailboxes'] = this.assignedMailboxes;
    return json;
  }

  /// Returns a new [EmailDomain] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDomain? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "EmailDomain[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "EmailDomain[id]" has a null value in JSON.');
        assert(json.containsKey(r'hostname'), 'Required key "EmailDomain[hostname]" is missing from JSON.');
        assert(json[r'hostname'] != null, 'Required key "EmailDomain[hostname]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "EmailDomain[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "EmailDomain[status]" has a null value in JSON.');
        return true;
      }());

      return EmailDomain(
        suggestedSubdomain: mapValueOfType<String>(json, r'suggested_subdomain'),
        rootGuidance: mapValueOfType<String>(json, r'root_guidance'),
        pauseReason: mapValueOfType<String>(json, r'pause_reason'),
        id: mapValueOfType<String>(json, r'id')!,
        hostname: mapValueOfType<String>(json, r'hostname')!,
        status: mapValueOfType<String>(json, r'status')!,
        guidance: mapValueOfType<String>(json, r'guidance'),
        receiving: mapValueOfType<bool>(json, r'receiving'),
        rootDomain: mapValueOfType<bool>(json, r'root_domain'),
        pausedAt: mapDateTime(json, r'paused_at', r''),
        lastCheckedAt: mapDateTime(json, r'last_checked_at', r''),
        ownershipVerifiedAt: mapDateTime(json, r'ownership_verified_at', r''),
        setupExpiresAt: mapDateTime(json, r'setup_expires_at', r''),
        readyAt: mapDateTime(json, r'ready_at', r''),
        requiredDnsRecords: DnsRecord.listFromJson(json[r'required_dns_records']),
        error: EmailDomainError.fromJson(json[r'error']),
        assignedMailboxes: EmailDomainAssignedMailboxesInner.listFromJson(json[r'assigned_mailboxes']),
      );
    }
    return null;
  }

  static List<EmailDomain> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDomain>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDomain.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDomain> mapFromJson(dynamic json) {
    final map = <String, EmailDomain>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDomain.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDomain-objects as value to a dart map
  static Map<String, List<EmailDomain>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDomain>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDomain.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'hostname',
    'status',
  };
}


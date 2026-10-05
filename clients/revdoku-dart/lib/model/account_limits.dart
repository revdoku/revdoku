//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AccountLimits {
  /// Returns a new [AccountLimits] instance.
  AccountLimits({
    required this.maxMailboxes,
    required this.maxMailboxCreationsPerMonth,
    required this.maxFilesPerMailbox,
    required this.maxCurrentFiles,
    required this.maxStorageBytes,
    required this.maxFileSizeBytes,
    required this.maxPdfSizeBytes,
    required this.maxFileVersionsPerFile,
    required this.maxEmailDomains,
    required this.maxReceivedEmailsPerMonth,
    required this.maxReceivedEmailBytesPerMonth,
    required this.maxReceivedEmailMessageBytes,
    required this.maxEmailAddressRotationsPerMonth,
    required this.maxAccountMembers,
    required this.maxApiKeys,
    required this.maxAgentConnections,
    required this.apiRateLimitRequestsPerMinute,
    required this.auditRetentionDays,
    required this.maxEmailAliasesPerMailbox,
  });

  /// Minimum value: 0
  int? maxMailboxes;

  /// Minimum value: 0
  int? maxMailboxCreationsPerMonth;

  /// Minimum value: 0
  int? maxFilesPerMailbox;

  /// Minimum value: 0
  int? maxCurrentFiles;

  /// Minimum value: 0
  int? maxStorageBytes;

  /// Minimum value: 0
  int? maxFileSizeBytes;

  /// Minimum value: 0
  int? maxPdfSizeBytes;

  /// Minimum value: 0
  int? maxFileVersionsPerFile;

  /// Minimum value: 0
  int? maxEmailDomains;

  /// Minimum value: 0
  int? maxReceivedEmailsPerMonth;

  /// Minimum value: 0
  int? maxReceivedEmailBytesPerMonth;

  /// Minimum value: 0
  int? maxReceivedEmailMessageBytes;

  /// Minimum value: 0
  int? maxEmailAddressRotationsPerMonth;

  /// Minimum value: 0
  int? maxAccountMembers;

  /// Minimum value: 0
  int? maxApiKeys;

  /// Minimum value: 0
  int? maxAgentConnections;

  /// Minimum value: 0
  int? apiRateLimitRequestsPerMinute;

  /// Minimum value: 0
  int? auditRetentionDays;

  /// Active retained email addresses per mailbox; Free always has zero.
  ///
  /// Minimum value: 0
  int maxEmailAliasesPerMailbox;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountLimits &&
    other.maxMailboxes == maxMailboxes &&
    other.maxMailboxCreationsPerMonth == maxMailboxCreationsPerMonth &&
    other.maxFilesPerMailbox == maxFilesPerMailbox &&
    other.maxCurrentFiles == maxCurrentFiles &&
    other.maxStorageBytes == maxStorageBytes &&
    other.maxFileSizeBytes == maxFileSizeBytes &&
    other.maxPdfSizeBytes == maxPdfSizeBytes &&
    other.maxFileVersionsPerFile == maxFileVersionsPerFile &&
    other.maxEmailDomains == maxEmailDomains &&
    other.maxReceivedEmailsPerMonth == maxReceivedEmailsPerMonth &&
    other.maxReceivedEmailBytesPerMonth == maxReceivedEmailBytesPerMonth &&
    other.maxReceivedEmailMessageBytes == maxReceivedEmailMessageBytes &&
    other.maxEmailAddressRotationsPerMonth == maxEmailAddressRotationsPerMonth &&
    other.maxAccountMembers == maxAccountMembers &&
    other.maxApiKeys == maxApiKeys &&
    other.maxAgentConnections == maxAgentConnections &&
    other.apiRateLimitRequestsPerMinute == apiRateLimitRequestsPerMinute &&
    other.auditRetentionDays == auditRetentionDays &&
    other.maxEmailAliasesPerMailbox == maxEmailAliasesPerMailbox;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (maxMailboxes == null ? 0 : maxMailboxes!.hashCode) +
    (maxMailboxCreationsPerMonth == null ? 0 : maxMailboxCreationsPerMonth!.hashCode) +
    (maxFilesPerMailbox == null ? 0 : maxFilesPerMailbox!.hashCode) +
    (maxCurrentFiles == null ? 0 : maxCurrentFiles!.hashCode) +
    (maxStorageBytes == null ? 0 : maxStorageBytes!.hashCode) +
    (maxFileSizeBytes == null ? 0 : maxFileSizeBytes!.hashCode) +
    (maxPdfSizeBytes == null ? 0 : maxPdfSizeBytes!.hashCode) +
    (maxFileVersionsPerFile == null ? 0 : maxFileVersionsPerFile!.hashCode) +
    (maxEmailDomains == null ? 0 : maxEmailDomains!.hashCode) +
    (maxReceivedEmailsPerMonth == null ? 0 : maxReceivedEmailsPerMonth!.hashCode) +
    (maxReceivedEmailBytesPerMonth == null ? 0 : maxReceivedEmailBytesPerMonth!.hashCode) +
    (maxReceivedEmailMessageBytes == null ? 0 : maxReceivedEmailMessageBytes!.hashCode) +
    (maxEmailAddressRotationsPerMonth == null ? 0 : maxEmailAddressRotationsPerMonth!.hashCode) +
    (maxAccountMembers == null ? 0 : maxAccountMembers!.hashCode) +
    (maxApiKeys == null ? 0 : maxApiKeys!.hashCode) +
    (maxAgentConnections == null ? 0 : maxAgentConnections!.hashCode) +
    (apiRateLimitRequestsPerMinute == null ? 0 : apiRateLimitRequestsPerMinute!.hashCode) +
    (auditRetentionDays == null ? 0 : auditRetentionDays!.hashCode) +
    (maxEmailAliasesPerMailbox.hashCode);

  @override
  String toString() => 'AccountLimits[maxMailboxes=$maxMailboxes, maxMailboxCreationsPerMonth=$maxMailboxCreationsPerMonth, maxFilesPerMailbox=$maxFilesPerMailbox, maxCurrentFiles=$maxCurrentFiles, maxStorageBytes=$maxStorageBytes, maxFileSizeBytes=$maxFileSizeBytes, maxPdfSizeBytes=$maxPdfSizeBytes, maxFileVersionsPerFile=$maxFileVersionsPerFile, maxEmailDomains=$maxEmailDomains, maxReceivedEmailsPerMonth=$maxReceivedEmailsPerMonth, maxReceivedEmailBytesPerMonth=$maxReceivedEmailBytesPerMonth, maxReceivedEmailMessageBytes=$maxReceivedEmailMessageBytes, maxEmailAddressRotationsPerMonth=$maxEmailAddressRotationsPerMonth, maxAccountMembers=$maxAccountMembers, maxApiKeys=$maxApiKeys, maxAgentConnections=$maxAgentConnections, apiRateLimitRequestsPerMinute=$apiRateLimitRequestsPerMinute, auditRetentionDays=$auditRetentionDays, maxEmailAliasesPerMailbox=$maxEmailAliasesPerMailbox]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.maxMailboxes != null) {
      json[r'max_mailboxes'] = this.maxMailboxes;
    } else {
      json[r'max_mailboxes'] = null;
    }
    if (this.maxMailboxCreationsPerMonth != null) {
      json[r'max_mailbox_creations_per_month'] = this.maxMailboxCreationsPerMonth;
    } else {
      json[r'max_mailbox_creations_per_month'] = null;
    }
    if (this.maxFilesPerMailbox != null) {
      json[r'max_files_per_mailbox'] = this.maxFilesPerMailbox;
    } else {
      json[r'max_files_per_mailbox'] = null;
    }
    if (this.maxCurrentFiles != null) {
      json[r'max_current_files'] = this.maxCurrentFiles;
    } else {
      json[r'max_current_files'] = null;
    }
    if (this.maxStorageBytes != null) {
      json[r'max_storage_bytes'] = this.maxStorageBytes;
    } else {
      json[r'max_storage_bytes'] = null;
    }
    if (this.maxFileSizeBytes != null) {
      json[r'max_file_size_bytes'] = this.maxFileSizeBytes;
    } else {
      json[r'max_file_size_bytes'] = null;
    }
    if (this.maxPdfSizeBytes != null) {
      json[r'max_pdf_size_bytes'] = this.maxPdfSizeBytes;
    } else {
      json[r'max_pdf_size_bytes'] = null;
    }
    if (this.maxFileVersionsPerFile != null) {
      json[r'max_file_versions_per_file'] = this.maxFileVersionsPerFile;
    } else {
      json[r'max_file_versions_per_file'] = null;
    }
    if (this.maxEmailDomains != null) {
      json[r'max_email_domains'] = this.maxEmailDomains;
    } else {
      json[r'max_email_domains'] = null;
    }
    if (this.maxReceivedEmailsPerMonth != null) {
      json[r'max_received_emails_per_month'] = this.maxReceivedEmailsPerMonth;
    } else {
      json[r'max_received_emails_per_month'] = null;
    }
    if (this.maxReceivedEmailBytesPerMonth != null) {
      json[r'max_received_email_bytes_per_month'] = this.maxReceivedEmailBytesPerMonth;
    } else {
      json[r'max_received_email_bytes_per_month'] = null;
    }
    if (this.maxReceivedEmailMessageBytes != null) {
      json[r'max_received_email_message_bytes'] = this.maxReceivedEmailMessageBytes;
    } else {
      json[r'max_received_email_message_bytes'] = null;
    }
    if (this.maxEmailAddressRotationsPerMonth != null) {
      json[r'max_email_address_rotations_per_month'] = this.maxEmailAddressRotationsPerMonth;
    } else {
      json[r'max_email_address_rotations_per_month'] = null;
    }
    if (this.maxAccountMembers != null) {
      json[r'max_account_members'] = this.maxAccountMembers;
    } else {
      json[r'max_account_members'] = null;
    }
    if (this.maxApiKeys != null) {
      json[r'max_api_keys'] = this.maxApiKeys;
    } else {
      json[r'max_api_keys'] = null;
    }
    if (this.maxAgentConnections != null) {
      json[r'max_agent_connections'] = this.maxAgentConnections;
    } else {
      json[r'max_agent_connections'] = null;
    }
    if (this.apiRateLimitRequestsPerMinute != null) {
      json[r'api_rate_limit_requests_per_minute'] = this.apiRateLimitRequestsPerMinute;
    } else {
      json[r'api_rate_limit_requests_per_minute'] = null;
    }
    if (this.auditRetentionDays != null) {
      json[r'audit_retention_days'] = this.auditRetentionDays;
    } else {
      json[r'audit_retention_days'] = null;
    }
      json[r'max_email_aliases_per_mailbox'] = this.maxEmailAliasesPerMailbox;
    return json;
  }

  /// Returns a new [AccountLimits] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountLimits? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'max_mailboxes'), 'Required key "AccountLimits[max_mailboxes]" is missing from JSON.');
        assert(json.containsKey(r'max_mailbox_creations_per_month'), 'Required key "AccountLimits[max_mailbox_creations_per_month]" is missing from JSON.');
        assert(json.containsKey(r'max_files_per_mailbox'), 'Required key "AccountLimits[max_files_per_mailbox]" is missing from JSON.');
        assert(json.containsKey(r'max_current_files'), 'Required key "AccountLimits[max_current_files]" is missing from JSON.');
        assert(json.containsKey(r'max_storage_bytes'), 'Required key "AccountLimits[max_storage_bytes]" is missing from JSON.');
        assert(json.containsKey(r'max_file_size_bytes'), 'Required key "AccountLimits[max_file_size_bytes]" is missing from JSON.');
        assert(json.containsKey(r'max_pdf_size_bytes'), 'Required key "AccountLimits[max_pdf_size_bytes]" is missing from JSON.');
        assert(json.containsKey(r'max_file_versions_per_file'), 'Required key "AccountLimits[max_file_versions_per_file]" is missing from JSON.');
        assert(json.containsKey(r'max_email_domains'), 'Required key "AccountLimits[max_email_domains]" is missing from JSON.');
        assert(json.containsKey(r'max_received_emails_per_month'), 'Required key "AccountLimits[max_received_emails_per_month]" is missing from JSON.');
        assert(json.containsKey(r'max_received_email_bytes_per_month'), 'Required key "AccountLimits[max_received_email_bytes_per_month]" is missing from JSON.');
        assert(json.containsKey(r'max_received_email_message_bytes'), 'Required key "AccountLimits[max_received_email_message_bytes]" is missing from JSON.');
        assert(json.containsKey(r'max_email_address_rotations_per_month'), 'Required key "AccountLimits[max_email_address_rotations_per_month]" is missing from JSON.');
        assert(json.containsKey(r'max_account_members'), 'Required key "AccountLimits[max_account_members]" is missing from JSON.');
        assert(json.containsKey(r'max_api_keys'), 'Required key "AccountLimits[max_api_keys]" is missing from JSON.');
        assert(json.containsKey(r'max_agent_connections'), 'Required key "AccountLimits[max_agent_connections]" is missing from JSON.');
        assert(json.containsKey(r'api_rate_limit_requests_per_minute'), 'Required key "AccountLimits[api_rate_limit_requests_per_minute]" is missing from JSON.');
        assert(json.containsKey(r'audit_retention_days'), 'Required key "AccountLimits[audit_retention_days]" is missing from JSON.');
        assert(json.containsKey(r'max_email_aliases_per_mailbox'), 'Required key "AccountLimits[max_email_aliases_per_mailbox]" is missing from JSON.');
        assert(json[r'max_email_aliases_per_mailbox'] != null, 'Required key "AccountLimits[max_email_aliases_per_mailbox]" has a null value in JSON.');
        return true;
      }());

      return AccountLimits(
        maxMailboxes: mapValueOfType<int>(json, r'max_mailboxes'),
        maxMailboxCreationsPerMonth: mapValueOfType<int>(json, r'max_mailbox_creations_per_month'),
        maxFilesPerMailbox: mapValueOfType<int>(json, r'max_files_per_mailbox'),
        maxCurrentFiles: mapValueOfType<int>(json, r'max_current_files'),
        maxStorageBytes: mapValueOfType<int>(json, r'max_storage_bytes'),
        maxFileSizeBytes: mapValueOfType<int>(json, r'max_file_size_bytes'),
        maxPdfSizeBytes: mapValueOfType<int>(json, r'max_pdf_size_bytes'),
        maxFileVersionsPerFile: mapValueOfType<int>(json, r'max_file_versions_per_file'),
        maxEmailDomains: mapValueOfType<int>(json, r'max_email_domains'),
        maxReceivedEmailsPerMonth: mapValueOfType<int>(json, r'max_received_emails_per_month'),
        maxReceivedEmailBytesPerMonth: mapValueOfType<int>(json, r'max_received_email_bytes_per_month'),
        maxReceivedEmailMessageBytes: mapValueOfType<int>(json, r'max_received_email_message_bytes'),
        maxEmailAddressRotationsPerMonth: mapValueOfType<int>(json, r'max_email_address_rotations_per_month'),
        maxAccountMembers: mapValueOfType<int>(json, r'max_account_members'),
        maxApiKeys: mapValueOfType<int>(json, r'max_api_keys'),
        maxAgentConnections: mapValueOfType<int>(json, r'max_agent_connections'),
        apiRateLimitRequestsPerMinute: mapValueOfType<int>(json, r'api_rate_limit_requests_per_minute'),
        auditRetentionDays: mapValueOfType<int>(json, r'audit_retention_days'),
        maxEmailAliasesPerMailbox: mapValueOfType<int>(json, r'max_email_aliases_per_mailbox')!,
      );
    }
    return null;
  }

  static List<AccountLimits> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountLimits>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountLimits.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountLimits> mapFromJson(dynamic json) {
    final map = <String, AccountLimits>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountLimits.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountLimits-objects as value to a dart map
  static Map<String, List<AccountLimits>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountLimits>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountLimits.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'max_mailboxes',
    'max_mailbox_creations_per_month',
    'max_files_per_mailbox',
    'max_current_files',
    'max_storage_bytes',
    'max_file_size_bytes',
    'max_pdf_size_bytes',
    'max_file_versions_per_file',
    'max_email_domains',
    'max_received_emails_per_month',
    'max_received_email_bytes_per_month',
    'max_received_email_message_bytes',
    'max_email_address_rotations_per_month',
    'max_account_members',
    'max_api_keys',
    'max_agent_connections',
    'api_rate_limit_requests_per_minute',
    'audit_retention_days',
    'max_email_aliases_per_mailbox',
  };
}


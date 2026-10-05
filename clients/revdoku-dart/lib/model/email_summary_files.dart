//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailSummaryFiles {
  /// Returns a new [EmailSummaryFiles] instance.
  EmailSummaryFiles({
    required this.bodyId,
    required this.originalId,
    this.attachmentIds = const [],
    this.directory,
  });

  String? bodyId;

  String? originalId;

  List<String> attachmentIds;

  /// Storage folder containing this email, without a trailing slash.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? directory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailSummaryFiles &&
    other.bodyId == bodyId &&
    other.originalId == originalId &&
    _deepEquality.equals(other.attachmentIds, attachmentIds) &&
    other.directory == directory;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (bodyId == null ? 0 : bodyId!.hashCode) +
    (originalId == null ? 0 : originalId!.hashCode) +
    (attachmentIds.hashCode) +
    (directory == null ? 0 : directory!.hashCode);

  @override
  String toString() => 'EmailSummaryFiles[bodyId=$bodyId, originalId=$originalId, attachmentIds=$attachmentIds, directory=$directory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.bodyId != null) {
      json[r'body_id'] = this.bodyId;
    } else {
      json[r'body_id'] = null;
    }
    if (this.originalId != null) {
      json[r'original_id'] = this.originalId;
    } else {
      json[r'original_id'] = null;
    }
      json[r'attachment_ids'] = this.attachmentIds;
    if (this.directory != null) {
      json[r'directory'] = this.directory;
    }
    return json;
  }

  /// Returns a new [EmailSummaryFiles] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailSummaryFiles? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'body_id'), 'Required key "EmailSummaryFiles[body_id]" is missing from JSON.');
        assert(json.containsKey(r'original_id'), 'Required key "EmailSummaryFiles[original_id]" is missing from JSON.');
        assert(json.containsKey(r'attachment_ids'), 'Required key "EmailSummaryFiles[attachment_ids]" is missing from JSON.');
        assert(json[r'attachment_ids'] != null, 'Required key "EmailSummaryFiles[attachment_ids]" has a null value in JSON.');
        return true;
      }());

      return EmailSummaryFiles(
        bodyId: mapValueOfType<String>(json, r'body_id'),
        originalId: mapValueOfType<String>(json, r'original_id'),
        attachmentIds: json[r'attachment_ids'] is Iterable
            ? (json[r'attachment_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        directory: mapValueOfType<String>(json, r'directory'),
      );
    }
    return null;
  }

  static List<EmailSummaryFiles> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSummaryFiles>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSummaryFiles.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailSummaryFiles> mapFromJson(dynamic json) {
    final map = <String, EmailSummaryFiles>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailSummaryFiles.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailSummaryFiles-objects as value to a dart map
  static Map<String, List<EmailSummaryFiles>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailSummaryFiles>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailSummaryFiles.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body_id',
    'original_id',
    'attachment_ids',
  };
}


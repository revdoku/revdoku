//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxCreateOptions {
  /// Returns a new [MailboxCreateOptions] instance.
  MailboxCreateOptions({
    this.description,
    this.metadata = const {},
    this.tagIds = const [],
    this.tagPaths = const [],
    this.email,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  Map<String, Object?> metadata;

  List<String> tagIds;

  List<String> tagPaths;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxEmailOptions? email;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxCreateOptions &&
    other.description == description &&
    _deepEquality.equals(other.metadata, metadata) &&
    _deepEquality.equals(other.tagIds, tagIds) &&
    _deepEquality.equals(other.tagPaths, tagPaths) &&
    other.email == email;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (description == null ? 0 : description!.hashCode) +
    (metadata.hashCode) +
    (tagIds.hashCode) +
    (tagPaths.hashCode) +
    (email == null ? 0 : email!.hashCode);

  @override
  String toString() => 'MailboxCreateOptions[description=$description, metadata=$metadata, tagIds=$tagIds, tagPaths=$tagPaths, email=$email]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.description != null) {
      json[r'description'] = this.description;
    }
      json[r'metadata'] = this.metadata;
      json[r'tag_ids'] = this.tagIds;
      json[r'tag_paths'] = this.tagPaths;
    if (this.email != null) {
      json[r'email'] = this.email;
    }
    return json;
  }

  /// Returns a new [MailboxCreateOptions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxCreateOptions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxCreateOptions(
        description: mapValueOfType<String>(json, r'description'),
        metadata: mapCastOfType<String, Object?>(json, r'metadata') ?? const {},
        tagIds: json[r'tag_ids'] is Iterable
            ? (json[r'tag_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        tagPaths: json[r'tag_paths'] is Iterable
            ? (json[r'tag_paths'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        email: MailboxEmailOptions.fromJson(json[r'email']),
      );
    }
    return null;
  }

  static List<MailboxCreateOptions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxCreateOptions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxCreateOptions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxCreateOptions> mapFromJson(dynamic json) {
    final map = <String, MailboxCreateOptions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxCreateOptions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxCreateOptions-objects as value to a dart map
  static Map<String, List<MailboxCreateOptions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxCreateOptions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxCreateOptions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


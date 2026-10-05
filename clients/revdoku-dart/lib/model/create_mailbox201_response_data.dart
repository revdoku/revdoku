//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CreateMailbox201ResponseData {
  /// Returns a new [CreateMailbox201ResponseData] instance.
  CreateMailbox201ResponseData({
    this.mailbox,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CreateMailbox201ResponseDataMailbox? mailbox;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateMailbox201ResponseData &&
    other.mailbox == mailbox;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mailbox == null ? 0 : mailbox!.hashCode);

  @override
  String toString() => 'CreateMailbox201ResponseData[mailbox=$mailbox]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.mailbox != null) {
      json[r'mailbox'] = this.mailbox;
    } else {
      json[r'mailbox'] = null;
    }
    return json;
  }

  /// Returns a new [CreateMailbox201ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateMailbox201ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return CreateMailbox201ResponseData(
        mailbox: CreateMailbox201ResponseDataMailbox.fromJson(json[r'mailbox']),
      );
    }
    return null;
  }

  static List<CreateMailbox201ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateMailbox201ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateMailbox201ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateMailbox201ResponseData> mapFromJson(dynamic json) {
    final map = <String, CreateMailbox201ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateMailbox201ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateMailbox201ResponseData-objects as value to a dart map
  static Map<String, List<CreateMailbox201ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateMailbox201ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateMailbox201ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


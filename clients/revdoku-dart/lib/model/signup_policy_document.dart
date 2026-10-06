//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SignupPolicyDocument {
  /// Returns a new [SignupPolicyDocument] instance.
  SignupPolicyDocument({
    required this.url,
    required this.version,
    required this.sha256,
    required this.text,
  });

  /// Canonical public URL.
  String url;

  /// Version of the packaged policy.
  String version;

  /// SHA-256 of the UTF-8 Markdown text.
  String sha256;

  /// Complete packaged policy in Markdown.
  String text;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignupPolicyDocument &&
    other.url == url &&
    other.version == version &&
    other.sha256 == sha256 &&
    other.text == text;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (version.hashCode) +
    (sha256.hashCode) +
    (text.hashCode);

  @override
  String toString() => 'SignupPolicyDocument[url=$url, version=$version, sha256=$sha256, text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'version'] = this.version;
      json[r'sha256'] = this.sha256;
      json[r'text'] = this.text;
    return json;
  }

  /// Returns a new [SignupPolicyDocument] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupPolicyDocument? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "SignupPolicyDocument[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "SignupPolicyDocument[url]" has a null value in JSON.');
        assert(json.containsKey(r'version'), 'Required key "SignupPolicyDocument[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "SignupPolicyDocument[version]" has a null value in JSON.');
        assert(json.containsKey(r'sha256'), 'Required key "SignupPolicyDocument[sha256]" is missing from JSON.');
        assert(json[r'sha256'] != null, 'Required key "SignupPolicyDocument[sha256]" has a null value in JSON.');
        assert(json.containsKey(r'text'), 'Required key "SignupPolicyDocument[text]" is missing from JSON.');
        assert(json[r'text'] != null, 'Required key "SignupPolicyDocument[text]" has a null value in JSON.');
        return true;
      }());

      return SignupPolicyDocument(
        url: mapValueOfType<String>(json, r'url')!,
        version: mapValueOfType<String>(json, r'version')!,
        sha256: mapValueOfType<String>(json, r'sha256')!,
        text: mapValueOfType<String>(json, r'text')!,
      );
    }
    return null;
  }

  static List<SignupPolicyDocument> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignupPolicyDocument>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupPolicyDocument.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupPolicyDocument> mapFromJson(dynamic json) {
    final map = <String, SignupPolicyDocument>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupPolicyDocument.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupPolicyDocument-objects as value to a dart map
  static Map<String, List<SignupPolicyDocument>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignupPolicyDocument>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupPolicyDocument.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'version',
    'sha256',
    'text',
  };
}


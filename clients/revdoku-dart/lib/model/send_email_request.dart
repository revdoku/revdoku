//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class SendEmailRequest {
  /// Returns a new [SendEmailRequest] instance.
  SendEmailRequest({
    this.to = const [],
    this.cc = const [],
    this.subject,
    required this.text,
    this.html,
    this.inReplyTo,
    this.attachmentIds = const [],
    this.accountId,
    this.reason,
  });

  /// Recipient addresses. Optional with in_reply_to; defaults to the original sender. To and cc together allow at most 10 addresses.
  List<String> to;

  /// Carbon-copy addresses. Bcc is not supported.
  List<String> cc;

  /// Required without in_reply_to. Defaults to \"Re: \" plus the original subject.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? subject;

  /// Plain-text body, up to 1 MiB.
  String text;

  /// Optional HTML body, up to 1 MiB.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? html;

  /// Received email ID to reply to. Sets reply headers and the conversation.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? inReplyTo;

  /// Existing file IDs in this mailbox to attach.
  List<String> attachmentIds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendEmailRequest &&
    _deepEquality.equals(other.to, to) &&
    _deepEquality.equals(other.cc, cc) &&
    other.subject == subject &&
    other.text == text &&
    other.html == html &&
    other.inReplyTo == inReplyTo &&
    _deepEquality.equals(other.attachmentIds, attachmentIds) &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (to.hashCode) +
    (cc.hashCode) +
    (subject == null ? 0 : subject!.hashCode) +
    (text.hashCode) +
    (html == null ? 0 : html!.hashCode) +
    (inReplyTo == null ? 0 : inReplyTo!.hashCode) +
    (attachmentIds.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'SendEmailRequest[to=$to, cc=$cc, subject=$subject, text=$text, html=$html, inReplyTo=$inReplyTo, attachmentIds=$attachmentIds, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'to'] = this.to;
      json[r'cc'] = this.cc;
    if (this.subject != null) {
      json[r'subject'] = this.subject;
    }
      json[r'text'] = this.text;
    if (this.html != null) {
      json[r'html'] = this.html;
    }
    if (this.inReplyTo != null) {
      json[r'in_reply_to'] = this.inReplyTo;
    }
      json[r'attachment_ids'] = this.attachmentIds;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    return json;
  }

  /// Returns a new [SendEmailRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendEmailRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'text'), 'Required key "SendEmailRequest[text]" is missing from JSON.');
        assert(json[r'text'] != null, 'Required key "SendEmailRequest[text]" has a null value in JSON.');
        return true;
      }());

      return SendEmailRequest(
        to: json[r'to'] is Iterable
            ? (json[r'to'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        cc: json[r'cc'] is Iterable
            ? (json[r'cc'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        subject: mapValueOfType<String>(json, r'subject'),
        text: mapValueOfType<String>(json, r'text')!,
        html: mapValueOfType<String>(json, r'html'),
        inReplyTo: mapValueOfType<String>(json, r'in_reply_to'),
        attachmentIds: json[r'attachment_ids'] is Iterable
            ? (json[r'attachment_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<SendEmailRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendEmailRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendEmailRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendEmailRequest> mapFromJson(dynamic json) {
    final map = <String, SendEmailRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendEmailRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendEmailRequest-objects as value to a dart map
  static Map<String, List<SendEmailRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendEmailRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendEmailRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'text',
  };
}


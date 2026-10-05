//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library revdoku.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/default_api.dart';

part 'model/account_identity.dart';
part 'model/account_identity_agency_account.dart';
part 'model/account_identity_permissions.dart';
part 'model/account_limits.dart';
part 'model/api_error.dart';
part 'model/api_error_error.dart';
part 'model/api_success.dart';
part 'model/create_account_email_domain_request.dart';
part 'model/create_client_account201_response.dart';
part 'model/create_client_account201_response_data.dart';
part 'model/create_client_account_request.dart';
part 'model/create_mailbox201_response.dart';
part 'model/create_mailbox201_response_data.dart';
part 'model/create_mailbox201_response_data_mailbox.dart';
part 'model/create_mailbox_email_alias_request.dart';
part 'model/create_mailbox_request.dart';
part 'model/create_mailbox_request_mailbox.dart';
part 'model/create_mailbox_request_mailbox_email.dart';
part 'model/decoded_email_address.dart';
part 'model/decoded_incoming_message.dart';
part 'model/decoded_incoming_message_attachments_inner.dart';
part 'model/download_email_original200_response.dart';
part 'model/download_email_original200_response_data.dart';
part 'model/email_attachment.dart';
part 'model/email_detail.dart';
part 'model/email_download.dart';
part 'model/email_forwarding.dart';
part 'model/email_forwarding_content.dart';
part 'model/email_pagination.dart';
part 'model/email_received_event.dart';
part 'model/email_received_event_data.dart';
part 'model/email_sender_allowlist.dart';
part 'model/email_summary.dart';
part 'model/email_summary_files.dart';
part 'model/file_pagination.dart';
part 'model/get_account200_response.dart';
part 'model/get_account_limits200_response.dart';
part 'model/get_account_limits200_response_data.dart';
part 'model/get_account_limits200_response_data_usage.dart';
part 'model/get_account_limits200_response_data_usage_mailbox_creations.dart';
part 'model/get_email200_response.dart';
part 'model/get_email200_response_data.dart';
part 'model/get_email_subscription200_response.dart';
part 'model/get_email_subscription200_response_data.dart';
part 'model/get_email_subscription200_response_data_subscription.dart';
part 'model/get_email_webhook200_response.dart';
part 'model/get_email_webhook200_response_data.dart';
part 'model/get_email_webhook200_response_data_webhook.dart';
part 'model/get_mailbox_email_settings200_response.dart';
part 'model/get_revdoku_status200_response.dart';
part 'model/get_revdoku_status200_response_data.dart';
part 'model/list_accounts200_response.dart';
part 'model/list_accounts200_response_data.dart';
part 'model/list_emails200_response.dart';
part 'model/list_emails200_response_data.dart';
part 'model/list_mailbox_files200_response.dart';
part 'model/list_mailbox_files200_response_data.dart';
part 'model/list_mailboxes200_response.dart';
part 'model/list_mailboxes200_response_data.dart';
part 'model/list_mailboxes200_response_data_mailboxes_inner.dart';
part 'model/mailbox_email.dart';
part 'model/mailbox_email_activity.dart';
part 'model/mailbox_email_aliases_inner.dart';
part 'model/mailbox_email_assignment.dart';
part 'model/mailbox_email_assignment_error.dart';
part 'model/mailbox_email_available_domains_inner.dart';
part 'model/mailbox_email_customization.dart';
part 'model/remove_account_email_domain_request.dart';
part 'model/resend_agent_signup_code_request.dart';
part 'model/rotate_mailbox_email_address_request.dart';
part 'model/set_email_webhook200_response.dart';
part 'model/set_email_webhook200_response_data.dart';
part 'model/set_email_webhook200_response_data_webhook.dart';
part 'model/set_email_webhook_request.dart';
part 'model/signup_challenge.dart';
part 'model/start_agent_signup202_response.dart';
part 'model/start_agent_signup202_response_data.dart';
part 'model/start_agent_signup_request.dart';
part 'model/update_email200_response.dart';
part 'model/update_email200_response_data.dart';
part 'model/update_email_request.dart';
part 'model/update_mailbox_email_allowlist200_response.dart';
part 'model/update_mailbox_email_allowlist200_response_data.dart';
part 'model/update_mailbox_email_allowlist_request.dart';
part 'model/update_mailbox_email_allowlist_request_sender_allowlist.dart';
part 'model/verify_account_email_domain_request.dart';
part 'model/verify_agent_signup200_response.dart';
part 'model/verify_agent_signup200_response_data.dart';
part 'model/verify_agent_signup200_response_data_signup.dart';
part 'model/verify_agent_signup201_response.dart';
part 'model/verify_agent_signup201_response_data.dart';
part 'model/verify_agent_signup201_response_data_account.dart';
part 'model/verify_agent_signup201_response_data_mailbox.dart';
part 'model/verify_agent_signup201_response_data_signup.dart';
part 'model/verify_agent_signup_request.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';

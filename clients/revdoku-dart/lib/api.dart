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
part 'model/account_list.dart';
part 'model/action_request.dart';
part 'model/add_upload_session_files_request.dart';
part 'model/agent_connection.dart';
part 'model/api_error.dart';
part 'model/api_error_error.dart';
part 'model/append_text200_response.dart';
part 'model/append_text_request.dart';
part 'model/append_text_result.dart';
part 'model/browser_link.dart';
part 'model/change_mailbox_address_request.dart';
part 'model/check_email_domain200_response.dart';
part 'model/code_requested.dart';
part 'model/connection.dart';
part 'model/connection_permissions.dart';
part 'model/connection_renewal.dart';
part 'model/create_browser_link201_response.dart';
part 'model/create_browser_link_request.dart';
part 'model/create_client_account201_response.dart';
part 'model/create_client_account201_response_data.dart';
part 'model/create_client_account_request.dart';
part 'model/create_email_alias_request.dart';
part 'model/create_email_domain201_response.dart';
part 'model/create_email_domain201_response_data.dart';
part 'model/create_email_domain_request.dart';
part 'model/create_mailbox201_response.dart';
part 'model/create_mailbox201_response_data.dart';
part 'model/create_mailbox_request.dart';
part 'model/create_upload_session201_response.dart';
part 'model/create_upload_session_request.dart';
part 'model/decoded_email_address.dart';
part 'model/decoded_incoming_message.dart';
part 'model/decoded_incoming_message_attachments_inner.dart';
part 'model/delete_email_domain200_response.dart';
part 'model/delete_email_domain_request.dart';
part 'model/delete_mailbox_request.dart';
part 'model/delete_result.dart';
part 'model/dns_record.dart';
part 'model/download.dart';
part 'model/email_alias.dart';
part 'model/email_attachment.dart';
part 'model/email_delivery.dart';
part 'model/email_detail.dart';
part 'model/email_domain.dart';
part 'model/email_domain_assigned_mailboxes_inner.dart';
part 'model/email_domain_assigned_mailboxes_inner_email.dart';
part 'model/email_domain_check.dart';
part 'model/email_domain_error.dart';
part 'model/email_domain_list.dart';
part 'model/email_forwarding.dart';
part 'model/email_forwarding_content.dart';
part 'model/email_list.dart';
part 'model/email_received_event.dart';
part 'model/email_received_event_data.dart';
part 'model/email_sender_allowlist.dart';
part 'model/email_subscription.dart';
part 'model/email_summary.dart';
part 'model/email_summary_files.dart';
part 'model/error_code.dart';
part 'model/exchange_connection_grant_request.dart';
part 'model/file_actor.dart';
part 'model/file_download.dart';
part 'model/file_key.dart';
part 'model/file_list.dart';
part 'model/file_upload_skip.dart';
part 'model/file_version.dart';
part 'model/file_version_list.dart';
part 'model/file_version_reason.dart';
part 'model/finalize_upload_session_request.dart';
part 'model/get_account_limits200_response.dart';
part 'model/get_account_limits200_response_data.dart';
part 'model/get_account_limits200_response_data_usage.dart';
part 'model/get_account_limits200_response_data_usage_mailbox_creations.dart';
part 'model/get_email200_response.dart';
part 'model/get_email200_response_data.dart';
part 'model/get_email_original_download200_response.dart';
part 'model/get_email_original_download200_response_data.dart';
part 'model/get_email_subscription200_response.dart';
part 'model/get_email_subscription200_response_data.dart';
part 'model/get_email_webhook200_response.dart';
part 'model/get_email_webhook200_response_data.dart';
part 'model/get_file_by_path200_response.dart';
part 'model/get_file_by_path200_response_data.dart';
part 'model/get_file_download200_response.dart';
part 'model/get_mailbox_email_settings200_response.dart';
part 'model/get_status200_response.dart';
part 'model/list_accounts200_response.dart';
part 'model/list_email_domains200_response.dart';
part 'model/list_emails200_response.dart';
part 'model/list_file_versions200_response.dart';
part 'model/list_files200_response.dart';
part 'model/list_mailboxes200_response.dart';
part 'model/mailbox.dart';
part 'model/mailbox_action.dart';
part 'model/mailbox_counts.dart';
part 'model/mailbox_create.dart';
part 'model/mailbox_email.dart';
part 'model/mailbox_email_options.dart';
part 'model/mailbox_email_settings.dart';
part 'model/mailbox_email_settings_assignment.dart';
part 'model/mailbox_email_settings_assignment_error.dart';
part 'model/mailbox_email_settings_available_domains_inner.dart';
part 'model/mailbox_email_settings_customization.dart';
part 'model/mailbox_file.dart';
part 'model/mailbox_list.dart';
part 'model/mailbox_lock.dart';
part 'model/mailbox_update.dart';
part 'model/move_file_request.dart';
part 'model/pagination.dart';
part 'model/path_operation_result.dart';
part 'model/prepare_file_upload201_response.dart';
part 'model/prepare_file_upload_request.dart';
part 'model/prepared_file_upload.dart';
part 'model/rename_file200_response.dart';
part 'model/rename_file_request.dart';
part 'model/request_sign_in_code200_response.dart';
part 'model/request_sign_in_code_request.dart';
part 'model/restore_file_version201_response.dart';
part 'model/restored_file_version.dart';
part 'model/save_upload_session_batch_request.dart';
part 'model/save_uploaded_file201_response.dart';
part 'model/save_uploaded_file_request.dart';
part 'model/saved_file.dart';
part 'model/send_email202_response.dart';
part 'model/send_email202_response_data.dart';
part 'model/send_email_request.dart';
part 'model/set_email_webhook200_response.dart';
part 'model/set_email_webhook200_response_data.dart';
part 'model/set_email_webhook_request.dart';
part 'model/status.dart';
part 'model/status_features.dart';
part 'model/status_user.dart';
part 'model/storage_upload.dart';
part 'model/update_email_allowlist200_response.dart';
part 'model/update_email_allowlist200_response_data.dart';
part 'model/update_email_allowlist_request.dart';
part 'model/update_email_allowlist_request_sender_allowlist.dart';
part 'model/update_email_request.dart';
part 'model/update_mailbox_request.dart';
part 'model/upload_blob.dart';
part 'model/upload_session.dart';
part 'model/upload_session_file.dart';
part 'model/upload_session_result.dart';
part 'model/upload_session_upload.dart';
part 'model/uploaded_file.dart';
part 'model/verify_email_domain_request.dart';
part 'model/verify_sign_in_code201_response.dart';
part 'model/verify_sign_in_code_request.dart';
part 'model/webhook.dart';
part 'model/webhook_with_secret.dart';


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

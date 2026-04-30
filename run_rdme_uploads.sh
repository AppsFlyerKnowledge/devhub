#!/bin/bash
# Run all rdme upload commands from GitHub Actions workflows with --branch=0.1_readme_support
# Usage: README_API_KEY=<your-key> ./run_rdme_uploads.sh

set -uo pipefail

if [ -z "${README_API_KEY:-}" ]; then
  echo "Error: README_API_KEY environment variable is required"
  echo "Usage: README_API_KEY=<your-key> ./run_rdme_uploads.sh"
  exit 1
fi

BRANCH="0.1_readme_support"
PASSED=0
FAILED=0
FAILED_CMDS=()

run_cmd() {
  local cmd="$1"
  echo "----------------------------------------"
  echo "Running: $cmd"
  if eval "$cmd"; then
    echo "PASSED"
    ((PASSED++))
  else
    echo "FAILED"
    ((FAILED++))
    FAILED_CMDS+=("$cmd")
  fi
  echo ""
  sleep 5
}

# openapi uploads
run_cmd "rdme openapi upload ./docs/apis/rta/web_s2s_api.yaml --key=$README_API_KEY --slug=web-server-to-server-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/management/app_list_ad_nets_api.yaml --key=$README_API_KEY --slug=app-list-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/audience/additional_identifiers_api.yaml --key=$README_API_KEY --slug=additional-identifiers-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/protect360/click_signing_api.yaml --key=$README_API_KEY --slug=click-signing-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/ROI360/incost_uploader.yaml --key=$README_API_KEY --slug=incost-api-1.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/management/user_management.yaml --key=$README_API_KEY --slug=user-management.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/management/app_management_v2.yaml --key=$README_API_KEY --slug=app-management-api-v20.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/rta/engagements_api.yaml --key=$README_API_KEY --slug=engagements-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/SKAD/skanv4api.yaml --key=$README_API_KEY --slug=skan-cv-schema-api-for-ad-networks-2.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/mobile/test_console_api.yaml --key=$README_API_KEY --slug=test-console-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/rta/preload_download_api.yaml --key=$README_API_KEY --slug=preload-measurement-api-1.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/audience/audience_import_api.yaml --key=$README_API_KEY --slug=audience-import-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/rta/s2s_events_api.yaml --key=$README_API_KEY --slug=legacy-server-to-server-events-api-for-mobile.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/audience/audience_external_api.yaml --key=$README_API_KEY --slug=audience-external-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/OneLink/ddlapi.yaml --key=$README_API_KEY --slug=deep-linking-rest-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/ROI360/true_revenue_api.yaml --key=$README_API_KEY --slug=roi360-net-revenue-api-v20.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/rta/s2s_events_api3.yaml --key=$README_API_KEY --slug=server-to-server-events-api-for-mobile.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/partnerIntSet/partner_integration_settings_api.yaml --key=$README_API_KEY --slug=partner-integration-settings-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/mos/pushapi_config_api.yaml --key=$README_API_KEY --slug=push-api-configuration-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/mos/raw_data_pull_api_tokenv2.yaml --key=$README_API_KEY --slug=raw-data-pull-api-v2-token.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/analytics/aggregate_pull_api_v2.yaml --key=$README_API_KEY --slug=aggregate-pull-api-v2-token.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/analytics/cohort_api.yaml --key=$README_API_KEY --slug=cohort-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/rta/ctv_c2s_events_api.yaml --key=$README_API_KEY --slug=pcconsolectv-client-app-events-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/OneLink/onelinkapi.yml --key=$README_API_KEY --slug=onelink-api-2.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/ROI360/adrevacctint.yaml --key=$README_API_KEY --slug=adrevenue-account-integrations-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/analytics/aggregate_pull_api_v1.yaml --key=$README_API_KEY --slug=aggregate-pull-api-v1-token.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/gcdapi/gcdapi.yaml --key=$README_API_KEY --slug=gcd-api-for-sdk-attribution-testing-1.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/audience/audiences_user_attr_import.yaml --key=$README_API_KEY --slug=audiences-user-attribution-import-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/SKAD/skan_postbacks_by_date_api.yaml --key=$README_API_KEY --slug=skan-aggregated-postback-by-arrival-date-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/OneLink/onelinkapi_v2.yml --key=$README_API_KEY --slug=onelink-api-v20.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/rta/ctv_events_api.yaml --key=$README_API_KEY --slug=pcconsolectv-events-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/SKAD/skan_agg_performance_report_api.yaml --key=$README_API_KEY --slug=skan-aggregated-performance-report-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/analytics/master_api.yaml --key=$README_API_KEY --slug=master-api.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/mos/raw_data_pull_api_tokenv1.yaml --key=$README_API_KEY --slug=raw-data-pull-api-v1-token.json --confirm-overwrite --branch=$BRANCH"
run_cmd "rdme openapi upload ./docs/apis/SKAD/skan_cv_schema_adv_api.yaml --key=$README_API_KEY --slug=skan-cv-schema-api-for-advertisers-1.json --confirm-overwrite --branch=$BRANCH"

# reference uploads
run_cmd "rdme reference upload ./docs/apis/ROI360/incost_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/management/app_management_v2_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/management/app_management_v2_errors.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/management/app_management_v2_formats.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/management/app_list_ad_nets_api_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/protect360/click_sign_api_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/rta/s2s_events_api3_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/management/bulk_users_management_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/OneLink/onelinkapi_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/OneLink/onelinkapi_v2_overview.md --key=$README_API_KEY --branch=$BRANCH"
run_cmd "rdme reference upload ./docs/apis/OneLink/migrate_to_onelink_api_v2.md --key=$README_API_KEY --branch=$BRANCH"

# Summary
echo "========================================"
echo "SUMMARY: $PASSED passed, $FAILED failed out of $((PASSED + FAILED)) total"
if [ $FAILED -gt 0 ]; then
  echo ""
  echo "Failed commands:"
  for cmd in "${FAILED_CMDS[@]}"; do
    echo "  - $cmd"
  done
  exit 1
fi

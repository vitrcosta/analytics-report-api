require 'google/apis/analyticsdata_v1alpha'

class MyAnalyticsDataService < Google::Apis::AnalyticsdataV1alpha::AnalyticsDataService
  def run_report(run_report_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
    command = make_simple_command(:post, "v1beta/properties/#{ENV['GA4_PROPERTY_ID']}:runReport", options)
    command.request_representation = Google::Apis::AnalyticsdataV1alpha::RunReportRequest::Representation
    command.request_object = run_report_request_object
    command.response_representation = Google::Apis::AnalyticsdataV1alpha::RunReportResponse::Representation
    command.response_class = Google::Apis::AnalyticsdataV1alpha::RunReportResponse
    command.query['fields'] = fields unless fields.nil?
    command.query['quotaUser'] = quota_user unless quota_user.nil?
    execute_or_queue_command(command, &block)
  end
end

class RunReportController < ApplicationController
  def index
    # Set up authentication
    scopes = [Google::Apis::AnalyticsdataV1alpha::AUTH_ANALYTICS_READONLY]
    credentials = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open("#{Rails.root}/#{ENV['ANALYTICS_DATA_CREDENTIALS']}"),
      scope: scopes
    )
    client = MyAnalyticsDataService.new
    client.authorization = credentials

    # Set the date range for the report
    end_date = Date.today.prev_day # Set the end date to yesterday
    start_date = end_date - 27 # Set the start date to 28 days ago
    # Build the request https://ga-dev-tools.google/ga4/query-explorer/ OR https://ga-dev-tools.google/query-explorer/
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'eventName')],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'eventCount'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ]
      # order_bys: [
      #   Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
      #     dimension: Google::Apis::AnalyticsdataV1alpha::DimensionOrderBy.new(dimension_name: 'name',
      #                                                                         order_type: 'ALPHABETIC'),
      #     desc: false
      #   )
      # ]
    )
    response = client.run_report(request)
    response.rows.map do |row|
      events = row.dimension_values.first.value.to_s
      count = row.metric_values.first.value.to_i
      p 'event: ' + events + ' count: ' + count.to_s
    end

    render json: response, status: 200
    # The returned object is of type Google::Analytics::Data::V1beta::RunReportResponse.
    #   p response
  end
end

require 'google/apis/analyticsdata_v1alpha'

class MyAnalyticsDataService < Google::Apis::AnalyticsdataV1alpha::AnalyticsDataService
  def run_report(property_id, run_report_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
    command = make_simple_command(:post, "v1beta/properties/#{property_id}:runReport", options)
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
  scopes = [Google::Apis::AnalyticsdataV1alpha::AUTH_ANALYTICS_READONLY]
  credentials = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open("#{Rails.root}/#{ENV['ANALYTICS_DATA_CREDENTIALS']}"),
    scope: scopes
  )
  $client = MyAnalyticsDataService.new
  $client.authorization = credentials

  def page_view
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'eventName')
      ],
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
      ],
      dimension_filter: Google::Apis::AnalyticsdataV1alpha::FilterExpression.new(
        filter: Google::Apis::AnalyticsdataV1alpha::Filter.new(
          field_name: 'eventName', string_filter: Google::Apis::AnalyticsdataV1alpha::StringFilter.new(
            value: 'page_view'
          )
        )
      ),
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(metric_name: 'eventCount',
                                                                              order_type: 'NUMERIC'),
          desc: false
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def date
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: params[:dimension])
      ],
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
      ],
      dimension_filter: Google::Apis::AnalyticsdataV1alpha::FilterExpression.new(
        filter: Google::Apis::AnalyticsdataV1alpha::Filter.new(
          field_name: 'eventName', string_filter: Google::Apis::AnalyticsdataV1alpha::StringFilter.new(
            value: 'page_view'
          )
        )
      ),
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          dimension: Google::Apis::AnalyticsdataV1alpha::DimensionOrderBy.new(
            dimension_name: params[:dimension],
            order_type: 'NUMERIC'
           ),
          desc: false
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def event_count
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'eventName')
      ],
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
      ],
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(
            metric_name: 'eventCount',
            order_type: 'NUMERIC'
          ),
          desc: true
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def new_users
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'newVsReturning')
      ],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'newUsers'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def origin
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'sessionSourceMedium')
      ],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'sessions'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ],
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(
            metric_name: 'sessions',
           order_type: 'NUMERIC'),
          desc: true
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def page_path
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'pagePath')
      ],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'screenPageViews'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ],
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(
            metric_name: 'screenPageViews',
          order_type: 'NUMERIC'),
          desc: true
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def landing_page
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'landingPage')
      ],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'sessions'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ],
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(
            metric_name: 'sessions',
            order_type: 'NUMERIC'),
          desc: true
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def city
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'city')
      ],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'sessions'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ],
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(
            metric_name: 'sessions',
            order_type: 'NUMERIC'
            ),
          desc: true
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end

  def device
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    request = Google::Apis::AnalyticsdataV1alpha::RunReportRequest.new(
      dimensions: [
        Google::Apis::AnalyticsdataV1alpha::Dimension.new(name: 'deviceCategory')
      ],
      metrics: [
        Google::Apis::AnalyticsdataV1alpha::Metric.new(
          name: 'totalUsers'
        )
      ],
      date_ranges: [
        Google::Apis::AnalyticsdataV1alpha::DateRange.new(
          start_date: start_date.strftime('%Y-%m-%d'),
          end_date: end_date.strftime('%Y-%m-%d')
        )
      ],
      order_bys: [
        Google::Apis::AnalyticsdataV1alpha::OrderBy.new(
          metric: Google::Apis::AnalyticsdataV1alpha::MetricOrderBy.new(
            metric_name: 'totalUsers',
            order_type: 'NUMERIC'
            ),
          desc: true
        )
      ]
    )
    property_id = params[:property_id]
    response = $client.run_report(property_id, request)
    render json: response, status: 200
  end
end

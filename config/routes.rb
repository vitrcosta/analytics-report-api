Rails.application.routes.draw do
  root 'run_report#event'

  get '/date', to: 'run_report#date'
  get '/page_view', to: 'run_report#page_view'
  get '/event_count', to: 'run_report#event_count'
  get '/new_users', to: 'run_report#new_users'
  get '/origin', to: 'run_report#origin'
  get '/page_path', to: 'run_report#page_path'
  get '/landing_page', to: 'run_report#landing_page'
  get '/city', to: 'run_report#city'
  get '/device', to: 'run_report#device'

  post '/pdf', to: 'generate#generate_pdf'
end

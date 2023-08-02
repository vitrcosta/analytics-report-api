class RunReportController < ApplicationController
    def generate_pdf
        pdf = Prawn::Document.new
        pdf do |pdf|
            pdf.image "#{Rails.root}/app/assets/images/logomarca-criativitta-menu.png", width: 130, height: 33, position: 405, vposition: 10
            pdf.text "RELATÓRIO DE ACESSOS - CRIATIVITTÁ"
            pdf.stroke_horizontal_rule
            pdf.move_down 20
            pdf.text "Período: " + params[:start_date] + " até " + params[:end_date]
            pdf.move_down 20
            image_data = StringIO.new( Base64.decode64(params[:image]))
            pdf.image(image_data)
          end
        send_data pdf.render, filename: 'relatorio.pdf', type: 'application/pdf'
    end
end
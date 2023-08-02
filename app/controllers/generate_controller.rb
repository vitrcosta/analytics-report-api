class RunReportController < ApplicationController
    def generate_pdf(params[:start_date], params[:end_date], params[:image])
        pdf = Prawn::Document.new
        pdf do |pdf|
            pdf.image "#{Rails.root}/app/assets/images/logomarca-criativitta-menu.png", width: 130, height: 33, position: 405, vposition: 10
            pdf.text "RELATÓRIO DE ACESSOS - CRIATIVITTÁ"
            pdf.stroke_horizontal_rule
            pdf.move_down 20
            pdf.text "Período: " + data_de + " até " + data_ate
            pdf.move_down 20
            image_data = StringIO.new( Base64.decode64(image) )
            pdf.image(image_data)
          end
        send_data pdf.render, filename: 'relatorio.pdf', type: 'application/pdf'
    end
end
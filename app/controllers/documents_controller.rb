# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy pdf]

  def index
    @documents = Document.all
  end

  def show
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)

    if @document.save
      redirect_to @document, notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  def update
    if @document.update(document_params)
      redirect_to @document, notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @document.destroy
    redirect_to documents_url, notice: 'Document was successfully destroyed.'
  end

  def pdf
    if @document.list_id.present?
      list = List.find(@document.list_id)
      data = list.data

      pdfs = []

      data.each_with_index do |d, index|
        html = render_to_string(template: "documents/pdf", layout: "pdf", locals: { document: @document })

        # Replace content
        d.each do |key, value|
          html.gsub!(/#\{#{key}\}/, value)
        end

        style_tag_options = [
          { path: Rails.root.join('app', 'assets', 'stylesheets', 'pdf.css').to_s }
        ]

        grover = Grover.new(html, style_tag_options:, format: 'A4')
        pdf_content = grover.to_pdf

        pdfs << { filename: "#{d[:name]}_#{index + 1}.pdf", content: pdf_content }
      end

      zip_filename = "documents_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.zip"
      temp_zipfile = Tempfile.new(zip_filename)

      Zip::OutputStream.open(temp_zipfile) { |zos| }

      zip_filename = "documents_#{Time.now.strftime('%Y%m%d%H%M%S')}.zip"

      pdfs.each do |file|
        Zip::File.open(temp_zipfile.path, Zip::File::CREATE) do |zipfile|
          zipfile.get_output_stream(file[:filename]) { |f| f.write(file[:content]) }
        end
      end

      # send_data pdf_content, filename: "#{@document.title}.pdf", type: "application/pdf"
      send_file temp_zipfile.path, filename: zip_filename, type: "application/zip"

      temp_zipfile.close
    else
      html = render_to_string(template: "documents/pdf", layout: "pdf", locals: { document: @document })

      style_tag_options = [
        { path: Rails.root.join('app', 'assets', 'stylesheets', 'pdf.css').to_s }
      ]

      grover = Grover.new(html, style_tag_options:, format: 'A4')
      pdf_content = grover.to_pdf

      send_data pdf_content, filename: "#{@document.title}", type: "application/pdf"
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :content, :list_id)
  end
end

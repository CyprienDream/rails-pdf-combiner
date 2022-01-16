class StaticPagesController < ApplicationController
  def home; end

  def upload
    file_one = params[:pdf_file]
    file_two = params[:pdf_file_two]

    File.open(Rails.root.join('public', 'uploads', file_one.original_filename), 'w:ascii-8bit') do |file|
      file.write(file_one.read)
    end

    File.open(Rails.root.join('public', 'uploads', file_two.original_filename), 'w:ascii-8bit') do |file|
      file.write(file_two.read)
    end

    combiner = CombinePDF.new
    combiner << CombinePDF.load("public/uploads/#{file_one.original_filename}")
    combiner << CombinePDF.load("public/uploads/#{file_two.original_filename}")
    # combiner.save 'combined pdf'

    send_data combiner.to_pdf, filename: "combined.pdf", type: "application/pdf"

  end
end

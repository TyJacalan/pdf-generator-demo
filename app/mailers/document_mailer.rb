class DocumentMailer < ApplicationMailer
  def send_pdf_email(email, pdf_content)
    @email = email

    attachments['document.pdf'] = {
      mime_type: 'application/pdf',
      content: pdf_content
    }

    mail(to: email, subject: 'Your PDF Document')
  end
end

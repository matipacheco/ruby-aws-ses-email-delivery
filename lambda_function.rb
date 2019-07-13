require 'json'
require 'aws-sdk'

def lambda_handler(event:, context:)
  encoding = "UTF-8"

  html_body = "<h4>Posible cliente!</h4>"\
    "<p><ul><li>Nombre: " + (event["name-input"] ? event["name-input"] : "-") + "</li>"\
    "<li>Correo: " + (event["email-input"] ? event["email-input"] : "-") + "</li></ul></p>"\
    "<p>Testimonio: " + (event["description-input"] ? event["description-input"] : "-")+ "</p>"

  begin
    ses = Aws::SES::Client.new(
      region: ENV["AWS_Zone"],
      access_key_id: ENV["ACCESS_KEY_ID"],
      secret_access_key: ENV["SECRET_ACCESS_KEY"]
    )

    resp = ses.send_email(
      {
        destination: {
          to_addresses: [
            ENV["SES_TO_ADDRESS"],
          ],
        },
        message: {
          body: {
            html: {
              charset: encoding,
              data: html_body
            },
          },
          subject: {
            charset: encoding,
            data: "Nuevo cliente!",
          },
        },
        source: ENV["SES_SOURCE_ADDRESS"]
      }
    )

    puts "success!"

    { statusCode: 200, body: resp, errors: nil }

  rescue Exception => e
    puts "error!"

    { statusCode: 500, body: nil, errors: e.to_s }

  end
end

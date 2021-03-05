# frozen_string_literal: true

#
# Uses Suara's SAP API to check if the user is valid.
# To send a request you MUST provide:
# - username: the username of the user
#
class SapSessionApi
  attr_reader :tipologia, :texto_ceco, :tipo_socio

  WSDL_URL = ENV.fetch("SAP_API_WSDL_URL")

  def initialize(username)
    @username = username
    @client = Savon.client(
      env_namespace: :soapenv,
      namespace_identifier: :urn,
      wsdl: WSDL_URL,
      convert_request_keys_to: :none
    )
    create_connection
  end

  private

  def create_connection
    response = @client.call(:z_decidim_ess_get_employee, message: { IUser: @username })
    response = response.to_hash[:z_decidim_ess_get_employee_response]
    @tipologia = response[:e_ubicacioespai]
    @texto_ceco = response[:e_kostl_txt]
    @tipo_socio = response[:e_tipo_soc]
  end
end

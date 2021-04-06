# frozen_string_literal: true

#
# Uses Suara's SAP API to check if the user is valid.
# To send a request you MUST provide:
# - username: the username of the user
#
class SapSessionApi
  attr_reader :ceco, :ceco_txt, :tipologia, :grup_empleados, :estat_soci, :derechovoto, :estat_ocup

  WSDL_URL = ENV.fetch("SAP_API_WSDL_URL")

  def initialize(email)
    @email = email
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
    response = @client.call(:z_hr_ess_decidim_personas, message: { IMail: @email })
    response = response.to_hash[:z_hr_ess_decidim_personas_response]
    @ceco = response[:ceco]
    @ceco_txt = response[:ceco_txt]
    @tipologia = response[:tipologia]
    @grup_empleados = response[:grup_empleados]
    @estat_soci = response[:estat_soci]
    @derechovoto = response[:derechovoto]
    @estat_ocup = response[:estat_ocup]
  end
end

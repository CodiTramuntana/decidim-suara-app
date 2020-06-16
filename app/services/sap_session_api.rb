# frozen_string_literal: true

#
# Uses Suara's SAP API to check if the user is valid.
# To send a request you MUST provide:
# - username: the username of the user
#
class SapSessionApi
  attr_reader :department_name

  WSDL_URL = ENV.fetch('SAP_API_WSDL_URL')

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
    response = @client.call(:z_hr_ess_get_employee, message: {IUser: @username})
    @department_name = response.to_hash[:z_hr_ess_get_employee_response][:ltext]
  end
end

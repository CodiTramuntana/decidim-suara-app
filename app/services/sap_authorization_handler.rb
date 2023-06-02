# frozen_string_literal: true

require "digest/md5"

# Checks the authorization against the census for Sant Cugat.
#
# This class performs a check against the official census database in order
# to verify the citizen's residence.
class SapAuthorizationHandler < Decidim::AuthorizationHandler
  include ActionView::Helpers::SanitizeHelper

  attribute :ceco, String
  attribute :ceco_txt, String
  attribute :tipologia, String
  attribute :grup_empleados, String
  attribute :estat_soci, String
  attribute :derechovoto, String
  attribute :estat_ocup, String

  # If you need to store any of the defined attributes in the authorization you
  # can do it here.
  #
  # You must return a Hash that will be serialized to the authorization when
  # it's created, and available though authorization.metadata
  def metadata
    {
      ceco: sap_session.ceco,
      ceco_txt: sap_session.ceco_txt,
      tipologia: sap_session.tipologia,
      grup_empleados: sap_session.grup_empleados,
      estat_soci: sap_session.estat_soci,
      derechovoto: sap_session.derechovoto,
      estat_ocup: sap_session.estat_ocup
    }
  end

  def unique_id
    Digest::MD5.hexdigest(
      "#{email}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  private

  def sap_session
    @sap_session ||= SapSessionApi.new(email)
  end

  def email
    user.email
  end
end

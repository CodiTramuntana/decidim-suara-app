# frozen_string_literal: true

require "digest/md5"

# Checks the authorization against the census for Sant Cugat.
#
# This class performs a check against the official census database in order
# to verify the citizen's residence.
class SapAuthorizationHandler < Decidim::AuthorizationHandler
  include Virtus::Multiparams
  include ActionView::Helpers::SanitizeHelper

  attribute :tipologia, String
  attribute :texto_ceco, String
  attribute :tipo_socio, String

#  validates_presence_of :department, :attrib

  # If you need to store any of the defined attributes in the authorization you
  # can do it here.
  #
  # You must return a Hash that will be serialized to the authorization when
  # it's created, and available though authorization.metadata
  def metadata
    {
      tipologia: sap_session.tipologia,
      texto_ceco: sap_session.texto_ceco,
      tipo_socio: sap_session.tipo_socio
    }
  end

  def unique_id
    Digest::MD5.hexdigest(
      "#{username}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  private

  attr_reader :sap_session

  def sap_session
    @sap_session ||= SapSessionApi.new("rubenrubioe")
  end

  def username
    user.email.split("@")[0]
  end
end

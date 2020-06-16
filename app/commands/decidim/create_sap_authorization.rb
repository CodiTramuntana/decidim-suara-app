# frozen_string_literal: true

module Decidim
  class CreateSapAuthorization < Rectify::Command
    # Public: Initializes the command.
    #
    # form - The form from which the data in this component comes from.
    def initialize(form, username)
      @form = form
      @username = username
    end
    # Public: Creates the Component.
    #
    # Broadcasts :ok if created, :invalid otherwise.
    def call
      return broadcast(:invalid) if form.invalid?

      verify_department

      broadcast(:ok)
    end

    private

    attr_reader :form, :username

    def verify_department
      sap_session = SapSessionApi.new(username)
      department = sap_session.department_name
    end

    def create_authorization
      Authorization.create_or_update_from(form.authorization)
    end
  end
end
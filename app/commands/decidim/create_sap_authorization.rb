# frozen_string_literal: true

module Decidim
  class CreateSapAuthorization < Rectify::Command
    # Public: Initializes the command.
    #
    # authorization - The authorization from which the data in this component comes from.
    def initialize(authorization)
      super(authorization)
      @authorization = authorization
    end

    # Public: Creates the Component.
    #
    # Broadcasts :ok if created, :invalid otherwise.
    def call
      return broadcast(:invalid) if authorization.invalid?

      create_authorization

      broadcast(:ok)
    end

    private

    attr_reader :authorization

    def create_authorization
      Authorization.create_or_update_from(authorization)
    end
  end
end

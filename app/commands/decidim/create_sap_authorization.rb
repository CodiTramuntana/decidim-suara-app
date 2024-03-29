# frozen_string_literal: true

module Decidim
  class CreateSapAuthorization < Decidim::Command
    # Public: Initializes the command.
    #
    # authorization - The authorization from which the data in this component comes from.
    # rubocop:disable Lint/MissingSuper
    def initialize(authorization)
      @authorization = authorization
    end
    # rubocop:enable Lint/MissingSuper

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

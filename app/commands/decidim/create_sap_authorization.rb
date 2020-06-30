# frozen_string_literal: true

module Decidim
  class CreateSapAuthorization < Rectify::Command
    # Public: Initializes the command.
    #
    # form - The form from which the data in this component comes from.
    def initialize(form)
      @form = form
    end
    # Public: Creates the Component.
    #
    # Broadcasts :ok if created, :invalid otherwise.
    def call
      return broadcast(:invalid) if form.invalid? || 
                                    form.authorization.invalid?

      create_authorization

      broadcast(:ok)
    end

    private

    attr_reader :form

    def create_authorization
      Authorization.create_or_update_from(form.authorization)
    end
  end
end

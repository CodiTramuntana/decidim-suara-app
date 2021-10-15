# frozen_string_literal: true

module Decidim
  module Assemblies
    # This query class filters published assemblies given an organization.
    class OrganizationPublishedAssemblies < Rectify::Query
      # rubocop:disable Lint/MissingSuper
      def initialize(organization, user = nil)
        @organization = organization
        @user = user
      end
      # rubocop:enable Lint/MissingSuper

      def query
        Rectify::Query.merge(
          OrganizationAssemblies.new(@organization),
          PublishedAssemblies.new,
          VisibleAssemblies.new(@user),
          AssembliesByTitle.new
        ).query
      end
    end
  end
end

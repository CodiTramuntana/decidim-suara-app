# frozen_string_literal: true

module Decidim
  module Assemblies
    # This query orders assemblies by importance, prioritizing promoted
    # assemblies.
    class AssembliesByTitle < Rectify::Query
      def query
        Decidim::Assembly.order(Arel.sql("title->'#{I18n.locale}' ASC"))
      end
    end
  end
end

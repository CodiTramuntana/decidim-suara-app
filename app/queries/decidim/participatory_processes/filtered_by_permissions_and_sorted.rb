# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This query orders assemblies by importance, prioritizing promoted
    # assemblies.
    class FilteredByPermissionsAndSorted < Rectify::Query
      include FilterParticipatorySpacesHelper

      def initialize(current_user, participatory_processes_query)
        super
        @current_user= current_user
        @participatory_processes_query = participatory_processes_query
      end

      attr_reader :current_user

      def query
        permissions(@participatory_processes_query).sort_by(&:weight)
      end
    end
  end
end

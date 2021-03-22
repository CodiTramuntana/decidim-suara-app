# frozen_string_literal: true

# This decorator change the behavior of the count in filters.
Decidim::ParticipatoryProcesses::ProcessFiltersCell.class_eval do
  include FilterParticipatorySpacesHelper

  def process_count_by_filter
    return @process_count_by_filter if @process_count_by_filter

    if current_user.present?
      if current_user.admin?
        @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
          filtered_processes = filtered_processes(filter_name).results
          processes = filtered_processes.groupless
          groups = Decidim::ParticipatoryProcessGroup.where(id: filtered_processes.grouped.group_ids)
          collection_by_filter.merge(filter_name => processes.count + groups.count)
        end
      else
        @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
          filtered_processes = filtered_processes(filter_name).results
          filtered_processes_ids = filtered_processes.present? ? permissions(filtered_processes(filter_name).results).map(&:decidim_participatory_process_group_id) : []
          processes = filtered_processes.groupless.present? ? permissions(filtered_processes(filter_name).results.groupless) : []

          groups = Decidim::ParticipatoryProcessGroup.where(id: filtered_processes_ids)
          collection_by_filter.merge(filter_name => processes.count + groups.count)
        end
      end

      @process_count_by_filter["all"] = @process_count_by_filter.values.sum
      @process_count_by_filter
    else
      @process_count_by_filter = { "active"=>0, "upcoming"=>0, "past"=>0, "all"=>0 }
    end
  end
end

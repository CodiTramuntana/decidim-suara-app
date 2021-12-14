# frozen_string_literal: true

# This decorator change the behavior of the count in filters.
Decidim::ParticipatoryProcesses::ProcessFiltersCell.class_eval do
  include SuaraPermissionsSupervisor

  alias_method :original_process_count_by_filter, :process_count_by_filter

  def process_count_by_filter
    if current_user&.admin?
      original_process_count_by_filter
    else
      @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
        filtered_processes = filtered_processes(filter_name).results
        filtered_processes_ids = filtered_processes.present? ? filter_by_suara_permissions(filtered_processes(filter_name).results).map(&:decidim_participatory_process_group_id) : []
        processes = filtered_processes.groupless.present? ? filter_by_suara_permissions(filtered_processes(filter_name).results.groupless) : []
        groups = Decidim::ParticipatoryProcessGroup.where(id: filtered_processes_ids)
        collection_by_filter.merge(filter_name => processes.count + groups.count)
      end
      @process_count_by_filter["all"] = @process_count_by_filter.values.sum
      @process_count_by_filter
    end
  end
end

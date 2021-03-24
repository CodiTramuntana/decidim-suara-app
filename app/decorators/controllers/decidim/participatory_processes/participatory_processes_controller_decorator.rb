# frozen_string_literal: true

# This decorator change the behavior of the promoted and group participatory processes
# to check permissions if you are not an admin user.
Decidim::ParticipatoryProcesses::ParticipatoryProcessesController.class_eval do
  include FilterParticipatorySpacesHelper

  private

  alias_method :original_promoted_participatory_processes, :promoted_participatory_processes
  alias_method :original_participatory_processes, :participatory_processes
  alias_method :original_participatory_process_groups, :participatory_process_groups

  def promoted_participatory_processes
    if current_user.admin?
      original_promoted_participatory_processes
    else
      permissions(original_promoted_participatory_processes).sort_by(&:weight)

    end
  end

  def participatory_processes
    if current_user.admin?
      original_participatory_processes
    else
      participatory_processes ||= filtered_processes.groupless
      participatory_processes.present? ? permissions(participatory_processes) : []
    end
  end

  def participatory_process_groups
    if current_user.admin?
      original_participatory_process_groups
    else
      filter_processes = permissions(filtered_processes).map(&:decidim_participatory_process_group_id)
      @participatory_process_groups ||= Decidim::ParticipatoryProcessGroup.where(id: filter_processes)
    end
  end
end

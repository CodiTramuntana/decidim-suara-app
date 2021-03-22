# frozen_string_literal: true

# This decorator change the behavior of the promoted and group participatory processes
# to check permissions if you are not an admin user.
Decidim::ParticipatoryProcesses::ParticipatoryProcessesController.class_eval do
  include FilterParticipatorySpacesHelper

  def promoted_participatory_processes
    return [] unless current_user

    if current_user.admin?
      @promoted_participatory_processes ||= published_processes | Decidim::ParticipatoryProcesses::PromotedParticipatoryProcesses.new
    else
      promoted_participatory_processes ||= published_processes | Decidim::ParticipatoryProcesses::PromotedParticipatoryProcesses.new
      permissions(promoted_participatory_processes).sort_by(&:weight)

    end
  end

  def participatory_processes
    return [] unless current_user

    if current_user.admin?
      @participatory_processes ||= filtered_processes.groupless
    else
      participatory_processes ||= filtered_processes.groupless
      participatory_processes.present? ? permissions(participatory_processes) : []
    end
  end

  def participatory_process_groups
    return [] unless current_user

    if current_user.admin?
      @participatory_process_groups ||= Decidim::ParticipatoryProcessGroup
                                        .where(id: filtered_processes.grouped.group_ids)
    else
      filter_processes = permissions(filtered_processes).map(&:decidim_participatory_process_group_id)
      @participatory_process_groups ||= Decidim::ParticipatoryProcessGroup.where(id: filter_processes)
    end
  end
end

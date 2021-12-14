# frozen_string_literal: true

# This decorator filter participatory processes by permissions in home content block.
Decidim::ParticipatoryProcesses::ContentBlocks::HighlightedProcessesCell.class_eval do
  include SuaraPermissionsSupervisor

  alias_method :original_highlighted_processes, :highlighted_processes

  def highlighted_processes
    @highlighted_processes ||= if current_user&.admin?
                                 original_highlighted_processes
                               else
                                 filter_by_suara_permissions(original_highlighted_processes)
                               end
  end
end

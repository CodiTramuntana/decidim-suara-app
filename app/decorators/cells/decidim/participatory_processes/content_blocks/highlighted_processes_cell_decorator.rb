# frozen_string_literal: true

# This decorator filter participatory processes by permissions in home content block.
Decidim::ParticipatoryProcesses::ContentBlocks::HighlightedProcessesCell.class_eval do
  include FilterParticipatorySpacesHelper

  alias_method :original_highlighted_processes, :highlighted_processes

  def highlighted_processes
    @highlighted_processes ||= if current_user.admin?
                                 original_highlighted_processes
                               else
                                 permissions(original_highlighted_processes)
                               end
  end
end

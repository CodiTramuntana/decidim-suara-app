# frozen_string_literal: true

# This decorator filter participatory processes by permissions in home content block.
Decidim::ParticipatoryProcesses::ContentBlocks::HighlightedProcessesCell.class_eval do
  include FilterParticipatorySpacesHelper

  def highlighted_processes
    @highlighted_processes ||= if current_user.admin?
                                 (
                                   Decidim::ParticipatoryProcesses::OrganizationPublishedParticipatoryProcesses.new(current_organization, current_user) |
                                   Decidim::ParticipatoryProcesses::HighlightedParticipatoryProcesses.new |
                                   Decidim::ParticipatoryProcesses::FilteredParticipatoryProcesses.new("active")
                                 ).query.includes([:organization]).limit(max_results)
                               else
                                 permissions((
                                    Decidim::ParticipatoryProcesses::OrganizationPublishedParticipatoryProcesses.new(current_organization, current_user) |
                                    Decidim::ParticipatoryProcesses::HighlightedParticipatoryProcesses.new |
                                    Decidim::ParticipatoryProcesses::FilteredParticipatoryProcesses.new("active")
                                  ).query.includes([:organization]).limit(max_results))
                               end
  end
end

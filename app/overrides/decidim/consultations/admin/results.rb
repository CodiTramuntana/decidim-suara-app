# frozen_string_literal: true

html= %Q(
<span class="button--title">
  <% if current_consultation.finished? && allowed_to?(:update, :consultation, consultation: current_consultation) %>
    <%= link_to t(".participants"), Rails.application.routes.url_helpers.exports_admin_consultation_participants_path(consultation_slug: current_consultation.slug), class: "button tiny button--title" %>
  <% else %>
    <span class="button tiny button--title disabled"><%= t(".participants") %></span>
  <% end %>
</span>
)
Deface::Override.new(virtual_path: +"decidim/consultations/admin/consultations/results",
                     original: "b9537a74f299daf1471d720baee7a3427c0eca0c",
                     name: "export_participation_button_in_consultations_results",
                     insert_top: "#consultations .card-title",
                     text: html
                     )

# frozen_string_literal: true

Deface::Override.new(virtual_path: "decidim/consultations/questions/_technical_data",
                     name: "hide_scope_in_question_technical_data",
                     surround: "erb[loud]:contains('question.scope')",
                     text: "
                      <% if translated_attribute(current_question.scope.name).present? %>
                        <%= render_original %>
                      <% end %>
                    ")

Deface::Override.new(virtual_path: "decidim/consultations/questions/_technical_data",
                     name: "hide_promoter_group_in_question_technical_data",
                     surround: "erb[loud]:contains('question.promoter_group')",
                     text: "
                      <% if translated_attribute(current_question.promoter_group).present? %>
                        <%= render_original %>
                      <% end %>
                    ")

Deface::Override.new(virtual_path: "decidim/consultations/questions/_technical_data",
                     name: "hide_participatory_scope_in_question_technical_data",
                     surround: "erb[loud]:contains('question.participatory_scope')",
                     text: "
                      <% if translated_attribute(current_question.participatory_scope).present? %>
                        <%= render_original %>
                      <% end %>
                    ")

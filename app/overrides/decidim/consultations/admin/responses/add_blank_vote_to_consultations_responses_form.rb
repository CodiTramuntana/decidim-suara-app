# frozen_string_literal: true

Deface::Override.new(virtual_path: 'decidim/consultations/admin/responses/_form',
                     name: 'add_blank_vote_to_consultations_responses_form',
                     insert_before: "erb[loud]:contains('form.translated :text_field')",
                     text: "
                        <% if current_question.blank_vote %>
                          <%= form.check_box :blank_vote, { onchange: 'blankVote(this)' } %>
                        <% end %>
                     ")

# frozen_string_literal: true

Deface::Override.new(virtual_path: 'decidim/consultations/admin/responses/_form',
                     name: 'add_blank_vote_to_consultations_responses_form',
                     insert_before: "erb[loud]:contains('form.translated :text_field')",
                     text: "
                        <% if current_question.blank_vote %>
                          <%= form.check_box :blank_vote, { onchange: 'blankVote(this)' }, { data: { 'es': I18n.with_locale(:es) { t('activemodel.attributes.response.blank_vote') },
                            'en': I18n.with_locale(:en) { t('activemodel.attributes.response.blank_vote') }, 'ca': I18n.with_locale(:ca) { t('activemodel.attributes.response.blank_vote') } } }.to_json %>
                        <% end %>
                     ")

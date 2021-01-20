# frozen_string_literal: true

Deface::Override.new(virtual_path: 'decidim/consultations/admin/question_configuration/_form',
                     name: 'add_blank_vote_to_question_configuration_form',
                     insert_before: "erb[loud]:contains('form.number_field :max_votes')",
                     text: '<%= form.check_box :blank_vote %>')

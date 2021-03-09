# frozen_string_literal: true

Deface::Override.new(virtual_path: "decidim/consultations/admin/responses/edit",
                     name: "add_js_to_edit_consultations_response",
                     insert_before: "erb[loud]:contains('<%= decidim_form_for @form')",
                     text: '<%= javascript_include_tag "decidim/admin/blank_vote" %>')

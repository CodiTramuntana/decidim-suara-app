# frozen_string_literal: true

Deface::Override.new(virtual_path: "decidim/consultations/admin/responses/_form",
                     name: "add_js_to_consultations_responses_form",
                     insert_before: "div.card",
                     text: '<%= javascript_pack_tag "consultations_admin_blank_vote" %>')

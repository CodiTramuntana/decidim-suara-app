# frozen_string_literal: true

Deface::Override.new(virtual_path: +"decidim/consultations/admin/consultations/_form",
                     original: "f908443977cedeb716644ecea78e0aa65d6f3bb3",
                     name: "change_start_voting_date_to_datetime_field_in_consultations_form",
                     replace: "erb[loud]:contains('form.date_field :start_voting_date')",
                     text: "
                      <%= form.datetime_field :start_voting_date %>
                     ")

Deface::Override.new(virtual_path: +"decidim/consultations/admin/consultations/_form",
                     original: "7211d39f7230b6a5ec31ed6b0a0d05073cc05a10",
                     name: "change_end_voting_date_to_datetime_field_in_consultations_form",
                     replace: "erb[loud]:contains('form.date_field :end_voting_date')",
                     text: "
                      <%= form.datetime_field :end_voting_date %>
                     ")

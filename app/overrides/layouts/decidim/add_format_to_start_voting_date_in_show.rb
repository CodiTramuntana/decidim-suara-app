# frozen_string_literal: true

Deface::Override.new(virtual_path: "layouts/decidim/_consultation_voting_data",
                     original: "7c477c3222e176edbfdd2e6f6578ad023fe32934",
                     name: "add_format_to_start_voting_date_in_show",
                     replace: "erb[loud]:contains('l consultation.start_voting_date')",
                     text: "
                      <%= l consultation.start_voting_date, format: '%d/%m/%Y - %H:%M' %>
                    ")

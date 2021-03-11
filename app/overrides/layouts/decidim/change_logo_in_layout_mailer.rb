# frozen_string_literal: true

Deface::Override.new(virtual_path: "layouts/decidim/_mailer_logo",
                     name: "change_logo_in_layout_mailer",
                     replace: "erb[loud]:contains('organization.name')",
                     text: "
                      <h4><b><%= t('mailer.suara.name') %></h4><b>
                      <h4><b><%= t('mailer.suara.logo_text') %></h4><b>")

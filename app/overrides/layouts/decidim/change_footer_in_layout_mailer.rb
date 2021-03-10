# frozen_string_literal: true

Deface::Override.new(virtual_path: "layouts/decidim/mailer",
                     name: "change_footer_in_layout_mailer",
                     replace: "erb[loud]:contains('link_to @organization.name.html_safe, decidim.root_url(host: @organization.host)')",
                     text: "<%= t('mailer.suara.footer_text') %>")

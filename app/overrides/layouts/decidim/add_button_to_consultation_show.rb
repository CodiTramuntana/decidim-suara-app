# frozen_string_literal: true

Deface::Override.new(virtual_path: "layouts/decidim/_question_header",
                     original: "bbc7f7b5218366802427e6048d0161f8c5404e6d",
                     name: "add_button_to_consultation_show",
                     insert_before: "div.consultations-title",
                     text: "
                      <div class='consultation__questions-button row column'>
                        <%= link_to t('.return_to_questions'),
                            consultation_path(question.consultation),
                            class: 'button button--sc' %>
                      </div>
                    ")

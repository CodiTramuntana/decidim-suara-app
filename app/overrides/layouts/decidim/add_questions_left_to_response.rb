# frozen_string_literal: true

Deface::Override.new(virtual_path: "layouts/decidim/_consultation_header",
                     original: "7cb40dc66937aa6148059453ec6c30b7d5bfe718",
                     name: "add_questions_left_to_response",
                     insert_after: "p.text-highlight",
                     text: "
                      <div class='questions-left-to-response'>
                        <span><%= t('.questions_left_to_response') %>:</span>
                        <span><%= @questions_left_to_response %>/<%= current_consultation.questions.size %></span>
                      </div>
                    ")

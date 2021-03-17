Deface::Override.new(virtual_path: "decidim/assemblies/admin/assemblies/_form",
                     name: "add_permissions_sections_to_assemblies_form",
                     insert_after: "div.card-section:last-child",
                     text: "
                      <div class='card-divider'>
                        <h2 class='card-title'><%= t('permissions.title') %></h2>
                      </div>
                      <div class='card-section'>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :ceco %>
                        </div>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :ceco_txt %>
                        </div>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :tipologia %>
                        </div>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :grup_empleados %>
                        </div>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :estat_soci %>
                        </div>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :derechovoto %>
                        </div>
                        <div class='columns xlarge-6'>
                          <%= form.text_field :estat_ocup %>
                        </div>
                      </div>
                     ")

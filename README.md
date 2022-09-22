# Decidim Suara

Free Open-Source participatory democracy, citizen participation and open government for cities and organizations

This is the open-source repository for decidim_application, based on [Decidim](https://github.com/decidim/decidim).

## Setting up the application

You will need to do some steps before having the app working properly once you've deployed it:

1. Open a Rails console in the server: `bundle exec rails console`
2. Create a System Admin user:
```ruby
user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
user.save!
```
3. Visit `<your app url>/system` and login with your system admin credentials
4. Create a new organization. Check the locales you want to use for that organization, and select a default locale.
5. Set the correct default host for the organization, otherwise the app will not work properly. Note that you need to include any subdomain you might be using.
6. Fill the rest of the form and submit it.

You're good to go!

## Decorators, overrides with Deface and override complete views

The following files must be checked in each upgrade of Decidim.

### Blank vote

- app/decorators/decidim/consultations/multi_vote_form_decorator.rb
- app/decorators/decidim/consultations/admin/create_response_decorator.rb
----------
- app/overrides/decidim/consultations/admin/responses/add_blank_vote_to_consultations_responses_form.rb
- app/overrides/decidim/consultations/admin/responses/add_js_to_consultations_responses_form.rb
- app/overrides/decidim/consultations/admin/responses/add_js_to_edit_consultations_responses.rb
- app/overrides/add_blank_vote_to_question_configuration_form.rb
----------
- app/views/decidim/consultations/question_multiple_votes/_form.html.erb

### Custom Suara permissions in Participatory Spaces

- app/decorators/commands/decidim/assemblies/admin/create_assembly_decorator.rb
- app/decorators/commands/decidim/consultations/admin/create_consultation_decorator.rb
----------
- app/overrides/decidim/assemblies/admin/assemblies/add_permissions_sections_to_assemblies_form.rb
- app/overrides/decidim/participatory_processes/admin/participatory_processes/add_permissions_sections_to_participatory_processes_form.rb
- app/overrides/decidim/consultations/admin/add_permissions_sections_to_consultations_form.rb

### Meetings: Filter by hours

- app/decorators/controllers/decidim/meetings/meetings_controller_decorator.rb
----------
- app/views/decidim/meetings/meetings/_filters.html.erb

### Meetings: Card visualization

- app/views/decidim/meetings/meetings/_meetings.html.erb

### From Module Action Delegator:
- app/decorators/queries/decidim/action_delegator/voted_with_direct_verification_decorator.rb

### Consultations: fields improvements

- app/overrides/decidim/consultations/questions/remove_fields_in_show_question.rb
- app/overrides/decidim/consultations/questions/hide_fields_in_technical_data.rb
- app/overrides/layouts/decidim/add_button_to_consultation_show.rb
- app/decorators/forms/decidim/consultations/question_form_decorator.rb
----------
- app/views/decidim/consultations/questions/show.html.erb

## Testing

Run `rake decidim:generate_external_test_app` to generate a dummy application.

Require missing factories in `spec/factories.rb`

Add `require "rails_helper"` to your specs and execute them from the **root directory**, i.e.:

`bundle exec rspec spec`

# License
This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.

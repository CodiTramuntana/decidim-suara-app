# Overrides

This document lists all the overrides that have been done at the Decidim platform. Those overrides can conflict with platform updates. During a platform upgrade they need to be compared to the ones of the Decidim project.

The best way to spot these problems is by reviewing the changes in the files that are overridden using git history and apply the changes manually.

## Controllers
#### Decidim::Devise::OmniauthRegistrationsController
#### Decidim::Devise::InvitationsController
The default invitations controller after_accept_path_for method redirect user to admin_path. This overrides redirect user to root_url

#### Decidim::Assembly
The default assembly visible_for method includes a distinct action on the query that generates an error
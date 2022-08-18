# DECIDIM.CLEAN.APP

This is a clean Decidim app to use as a starting point for other Decidim app projects.

## Fork the repository

A fork is a copy of a repository. Forking a repository allows you to make changes without affecting the original project.

In the top-right corner of the page, click **Fork**.

## Keep your fork synced

To keep your fork up-to-date with the upstream repository, i.e., to upgrade decidim, you must configure a remote that points to the upstream repository in Git.

```console
# List the current configured remote repository for your fork.
$ git remote -v
# Specify the new remote upstream repository that will be synced with the fork.
$ git remote add decidim-clean git@gitlab.coditdev.net:decidim/decidim-clean-app.git
# Verify the new decidim-clean repository you've specified for your fork.
$ git remote -v
```
Syncing a fork
```console
# Check out your fork's local master branch.
$ git checkout master
# Incorporate changes from the decidim-clean repository into the current branch.
$ git pull decidim-clean
```

## Customize your fork

The following files should be modified:

- package.json
- config/application.rb
- config/initializers/decidim.rb

## Testing

Run `bin/rake decidim:generate_external_test_app` to generate a dummy application to test both the application and the modules.

Require missing factories in `spec/factories.rb`

Add `require "rails_helper"` to your specs and execute them from the **root directory**, i.e.:
 	
## Upgrades with clean-app
	
Documentation in `docs/upgrade_apps.md`.

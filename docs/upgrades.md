## From v0.22 to v0.23

### Debates and Comments are now in global search

Debates and Comments have been added to the global search and need to be indexed, otherwise all previous content won't be available as search results. You should run this in a Rails console at your server or create a migration to do it.

Please be aware that it could take a while if your database has a lot of content.
```ruby
Decidim::Comments::Comment.find_each(&:try_update_index_for_search_resource)
Decidim::Debates::Debate.find_each(&:try_update_index_for_search_resource)
```
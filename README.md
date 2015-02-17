# URorL
An URL shortener, in Ruby on Rails.
User goes into the application, inputs an URL, and get back a shorter URL.
This url, when typed/copied into a browser, redirects to the original URL.

## Install
You need to have Ruby 2, Rails 4, and SQLite 3 installed first, then:
```
git clone https://github.com/xavierpriour/urorl.git
cd urorl
bundle
rake db:migrate
rails server
```

## Features
This application has the basic URL shortening features:
- turn an URL into a (usually) smaller URL
- smaller URL will redirect to initial URL
- submitting the same URL results in the same small URL being returned

From a technical point of view
- it uses Ruby on Rails 4 (on Ruby 2)
- styling is provided by Bootstrap
- and tests use RSpec

What was considered but finally left out due to time constraints
- a pagination on the main list
- checking the supplied URL is up before shortening
- internationalization
- HAML templates
- all sorts of info or stat to add to an URL (screenshots, number of clicks, etc.)
- a better-looking style

## Design considerations

### Shortening
The short URL is computed by getting the internal ID of the Url object (an integer), and then turning it into a short word with only 0-9 and a-z. This transformation is done by simply writing the ID in base 36.

As this operation requires knowledge of the Url ID, it has to be done after the object is saved, to avoid race conditions. We do it in an 'after_create' hook, which provides the added bonus of rolling back the whole save if it fails.

### Routes
From a routing point of view, the shortened URLs are considered a resource, with edit operations disabled (to avoid a whole range of possible collisions). It gives a nice REST API to manage them.

The redirection is an additional action on this resource.
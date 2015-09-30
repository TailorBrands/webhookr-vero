# Webhookr::Vero

[![Circle CI](https://circleci.com/gh/TailorBrands/webhookr-vero.svg?style=svg)](https://circleci.com/gh/TailorBrands/webhookr-vero)
[![Code Climate](https://codeclimate.com/github/TailorBrands/webhookr-vero/badges/gpa.svg)](https://codeclimate.com/github/TailorBrands/webhookr-vero)

This gem is a plugin for [Webhookr](https://github.com/zoocasa/webhookr) that enables
your application to accept [webhooks from vero](http://www.getvero.com/help/reporting/setting-up-veros-webhooks/).

## Installation

Add this line to your application's Gemfile:

    gem 'webhookr-vero'

Or install it yourself:

    $ gem install webhookr-vero

[webhookr](https://github.com/zoocasa/webhookr) is installed as a dependency of webhookr-vero. If you have not [setup Webhookr](https://github.com/zoocasa/webhookr#usage--setup), do so now:

```console
rails g webhookr:add_route
```

## Usage

Once you have the gem installed run the generator to add the code to your initializer.
An initializer will be created if you do not have one.

```console
rails g webhookr:vero:init *initializer_name* -s
```

Run the generator to create an example file to handle vero webhooks.

```console
rails g webhookr:vero:example_hooks
```

Or create a vero handler class for any event that you want to handle. For example
to handle unsubscribes you would create a class as follows:

```ruby
class VeroHooks
  def on_unsubscribed(incoming)
    # Your custom logic goes here.
    user = incoming.payload.user
    puts("User unsubscribed: (#{user.email})")
  end
end
```

For a complete list of events, and the payload format, see below.

Edit config/initializers/*initializer_name* and change the commented line to point to
your custom vero event handling class. If your class was called *VeroHooks*
the configuration line would look like this:

```ruby
  Webhookr::Vero::Adapter.config.callback = VeroHooks
```

To see the list of vero URLs your application can use when you configure
vero webhooks,
run the provided webhookr rake task:

```console
rake webhookr:services
```

Example output:

```console
vero:
  GET	/webhooks/events/vero/19xl64emxvn
  POST	/webhooks/events/vero/19xl64emxvn
```

## vero Events & Payload

### Events

All webhook events are supported. For further information on these events, see the
[vero documentation](http://www.getvero.com/help/reporting/setting-up-veros-webhooks/).

<table>
  <tr>
    <th>Vero Event</th>
    <th>Event Handler</th>
  </tr>
  <tr>
    <td>Email Sent</td>
    <td>on_sent(incoming)</td>
  </tr>
  <tr>
    <td>Email Delivered</td>
    <td>on_delivered(incoming)</td>
  </tr>
  <tr>
    <td>Email Opened</td>
    <td>on_opened(incoming)</td>
  </tr>
  <tr>
    <td>Email Clicked</td>
    <td>on_clicked(incoming)</td>
  </tr>
  <tr>
    <td>Email Bounced</td>
    <td>on_bounced(incoming)</td>
  </tr>
  <tr>
    <td>User Unsubscribed</td>
    <td>on_unsubscribed(incoming)</td>
  </tr>
  <tr>
    <td>User Updated</td>
    <td>on_user_updated(incoming)</td>
  </tr>
</table>

### Payload

The payload is the full payload data from as per the
[vero documentation](http://www.getvero.com/help/reporting/setting-up-veros-webhooks/), converted to an OpenStruct
for ease of access. Examples can be found in the example hook file.

### <a name="supported_services"></a>Supported Service - vero

* [http://www.getvero.com/help/reporting/setting-up-veros-webhooks/](vero - version: 2015-09-29)

## <a name="works_with"></a>Works with:

webhookr-vero works with Rails 3.1, 3.2 and 4.0

### Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that
version should be immediately yanked and/or a new version should be immediately released that restores
compatibility. Breaking changes to the public API will only be introduced with new major versions. As a
result of this policy, once this gem reaches a 1.0 release, you can (and should) specify a dependency on
this gem using the [Pessimistic Version Constraint](http://docs.rubygems.org/read/chapter/16#page74) with
two digits of precision. For example:

    spec.add_dependency 'webhookr-vero', '~> 1.0'

While this gem is currently a 0.x release, suggestion is to require the exact version that works for your code:

    spec.add_dependency 'webhookr-vero', '0.0.1'

## License

webhookr-vero is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## About Tailor Brands

[Check us out!](https://www.tailorbrands.com)

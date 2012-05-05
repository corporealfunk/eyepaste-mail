# eyepaste-mail

## Description

eyepaste-mail is a ruby gem that implements a "mail interceptor" as specified by the popular [Mail](https://github.com/mikel/mail) gem.

After registering the eyepaste-mail interceptor with the Mail gem, any emails sent with Mail are inspected before delivery and the "to" addresses are munged in the following way:

`inbox@example.com -> inbox_example.com@eyepaste.com`

After delivery, the above email would be available at:

`http://www.eyepaste.com/inbox/inbox_example.com@eyepaste.com`

And as RSS at:

`http://www.eyepaste.com/inbox/inbox_example.com@eyepaste.com.rss`


## Whitelisting

By default, the eyepaste-mail interceptor munges all addresses. To allow some addresses to pass through unaltered, you can define a whitelist in the following ways:

```ruby
# pass a regexp
Eyepaste::Mail::Interceptor.set_white_list = /.+?@example.com/

# pass an array of regexps
Eyepaste::Mail::Interceptor.set_white_list = [/.+?@example.com/, /^testing_.+?@example.com/]

# pass a block, it will be called everytime a message is examined and munged
Eyepaste::Mail::Interceptor.set_white_list do
  # must return a regexp object or array of regexp objects
end
```

## Rails

Make sure eyepaste-mail is required by your Gemfile and you have then run `bundle install`

To only munge emails in a particular environment, you can place the following in an environment file. For development, place in `config/environments/development.rb`:

```ruby
# optionally define a white_list:
Eyepaste::Mail::Interceptor.set_white_list = /.+?@example.com/
ActionMailer::Base.register_interceptor(Eyepaste::Mail::Interceptor)
```

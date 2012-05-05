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

# pass a block, it will be called every time a message is examined and munged
Eyepaste::Mail::Interceptor.set_white_list do
  # must return a regexp object or array of regexp objects
end
```

## Registering The Interceptor

To register the interceptor with the Mail gem, call:

```ruby
# optionally define a white_list:
Eyepaste::Mail::Interceptor.set_white_list = /.+?@example.com/

# register with Mail
Mail.register_interceptor(Eyepaste::Mail::Interceptor)
```


## Rails 3.2

Make sure eyepaste-mail is required by your Gemfile and you have then run `bundle install`

To only munge emails in a particular environment, you can place the following in an environment file. For development, place in `config/environments/development.rb`:

```ruby
# optionally define a white_list:
Eyepaste::Mail::Interceptor.set_white_list = /.+?@example.com/

# register with ActionMailer::Base (which wraps the call to `Mail::register_interceptor`)
ActionMailer::Base.register_interceptor(Eyepaste::Mail::Interceptor)
```

## License

eyepaste-email is licensed under the MIT license:

Copyright (c) 2012. Jon Moniaci.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

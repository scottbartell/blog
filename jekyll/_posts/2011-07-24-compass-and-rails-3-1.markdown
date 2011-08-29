---
layout: post
title: Compass and Rails 3.1
tags: [compass, css, development, rails]
---

Here's how I finally got Compass working with Rails 3.1rc4 (with includes, sprites, etc).

Gemfile excerpt:

{{gist: 1103112, Gemfile}}

config/compass.rb excerpt:

{{gist: 1103112, compass.rb}}

**That's it.** You don't have to do any of the crazy initializer hacks or anything like that. (If you were doing that, you can remove it all). The rest of my Gemfile and compass.rb are just standard stuff. Here's my [full compass.rb](https://gist.github.com/1103112#file_full_compass.rb) if that helps though.

The only other thing you'll need to do is be sure all of your stylesheets are in `app/assets/stylesheets/` and end in `.css.scss` or `.css.sass`. Eventually you won't have to include the `.css` part if you don't want to, but for now, it's required (due to Sprockets).

Big thanks to [Jon McCartie](http://twitter.com/jmccartie) and [
Chris Eppstein](http://twitter.com/chriseppstein) for all of their help!

### Update: Rails 3.1.0.rc5

Rails 3.1.0.rc5 just came out. Here's the updates for rc5.

Gemfile excerpt:

{{gist: 1103112, Gemfile_rc5.rb}}

**That's it!** Your compass.rb remains the same as before with `http_images_path`. You don't need to add `.css` to partials' file names any more now!

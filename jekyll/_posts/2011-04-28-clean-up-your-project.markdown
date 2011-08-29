---
layout: post
title: Clean Up Your Project
tags: [cocoa, development, ios, rake, ruby, scribd]
---

Many of the apps I work on are usually 100% custom. There is rarely any system UI components visible to the user. Styling the crap out of apps like this makes for tons of images in my iOS projects to get everything the way the designer wants. I'm starting to `drawRect:` stuff more these days because it makes it easier to reuse, but anyway.

There are literally hundreds of images in the [Scribd](http://samsoff.es/posts/im-moving-to-san-francisco) app I've been working on. Designers changing their mind plus everything custom leaves a lot of images behind that are no longer used. Our application was starting to be several megs and a lot of it was unused images. So... being the programmer I am, *I wrote a script*.

{{gist: 947827}}

It basically searches all of your source files for references for `[UIImage imageWithName:@"image_name_here"]`. Then it looks at all of the images on disk and removes any you didn't reference. I setup a whitelist for icons and other images I don't reference directly. You might need to tweak the paths a bit to work for your setup.

Hopefully this little [rake task](http://railscasts.com/episodes/66-custom-rake-tasks) helps someone clean up their project too.

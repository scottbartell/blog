---
layout: post
title: Archiving NSManagedObject with NSCoding
tags: [cocoa, core-data, development]
---

Several of the apps I have been working on lately have been using [Core Data](http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html). Core Data is pretty sweet. So far, I really like it.

I needed to persist an array of NSManagedObjects to NSUserDefaults to persist the state of the application between launches. Obviously, I could have done this with another attribute on the Core Data entity, but this approach seemed a lot simpler. I was surprised that NSManagedObject didn't conform to NSCoding. I guess that makes sense because if you store any custom types in your entity, it wouldn't know how to archive them. In my case, (and I would assume most others) I didn't want to archive the entire object since it was already store in Core Data. I just needed to store the object ID.

This was actually really easy. See:

{{gist: 317794, SSManagedObject.h}}
{{gist: 317794, SSManagedObject.m}}

I always add `+ (id)sharedAppDelegate` to my application delegate to save some typing:

{{gist: 317794, AppDelegate.m}}

Pretty simple right? Then you can do something like this to archive your objects:

{{gist: 317794, archive.m}}

Unarchiving is also super easy:

{{gist: 317794, unarchive.m}}

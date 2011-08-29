---
layout: post
title: Archiving NSManagedObject with NSCoding
tags: [cocoa, core-data, development]
---

Several of the apps I have been working on lately have been using [Core Data](http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html). Core Data is pretty sweet. So far, I really like it.

I needed to persist an array of NSManagedObjects to NSUserDefaults to persist the state of the application between launches. Obviously, I could have done this with another attribute on the Core Data entity, but this approach seemed a lot simpler. I was surprised that NSManagedObject didn't conform to NSCoding. I guess that makes sense because if you store any custom types in your entity, it wouldn't know how to archive them. In my case, (and I would assume most others) I didn't want to archive the entire object since it was already store in Core Data. I just needed to store the object ID.

This was actually really easy. See:

{% highlight objc %}
//
//  SSManagedObject.h
//  Archiving NSManagedObject with NSCoding
//
//  Created by Sam Soffes on 2/28/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

extern NSString *kURIRepresentationKey;

@interface SSManagedObject : NSManagedObject <NSCoding> {

}

@end
{% endhighlight %}

{% highlight objc %}
//
//  SSManagedObject.m
//  Archiving NSManagedObject with NSCoding
//
//  Created by Sam Soffes on 2/28/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSManagedObject.h"
#import "AppDelegate.h"

NSString *kURIRepresentationKey = @"URIRepresentation";

@implementation SSManagedObject

- (id)initWithCoder:(NSCoder *)decoder {
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    NSPersistentStoreCoordinator *psc = [appDelegate persistentStoreCoordinator];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    self = (SSManagedObject *)[[context objectWithID:[psc managedObjectIDForURIRepresentation:(NSURL *)[decoder decodeObjectForKey:kURIRepresentationKey]]] retain];
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[[self objectID] URIRepresentation] forKey:kURIRepresentationKey];
}

@end
{% endhighlight %}


I always add `+ (id)sharedAppDelegate` to my application delegate to save some typing:

{% highlight objc %}
+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
{% endhighlight %}

Pretty simple right? Then you can do something like this to archive your objects:

{% highlight objc %}
[[[AppDelegate sharedAppDelegate] managedObjectContext] save:nil];
NSData *archivedObjects = [NSKeyedArchiver archivedDataWithRootObject:objects];

NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
[userDefaults setObject:archivedObjects forKey:@"someKey"];
[userDefaults synchronize];
{% endhighlight %}

Unarchiving is also super easy:

{% highlight objc %}
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
NSData *objectsData = [userDefaults objectForKey:@"someKey"];
if ([objectsData length] > 0) {
    NSArray *objects = [NSKeyedUnarchiver unarchiveObjectWithData:objectsData]];
}
{% endhighlight %}

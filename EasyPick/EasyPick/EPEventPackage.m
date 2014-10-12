//
//  EPEventPackage.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/12/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "EPEventPackage.h"

@implementation EPEventPackage



- (instancetype)initWithDictionary: (NSDictionary* ) jsonDict
{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    
    
    return self;
    
}


- (void) loadFromJson: (NSDictionary* ) jsonDict
{
    /*/*
     "eventName": "John",
     "category": "Doe",
     "subCategory": "Doe",
     "price": "value",
     "image": "value",
     "time": "value",
     "location": "value",

     */
    
    if(jsonDict == nil)
        return;
    
    
    self.eventName = [jsonDict objectForKey:@"eventName"];
    self.category = [jsonDict objectForKey:@"category"];
    self.subCategory = [jsonDict objectForKey:@"subCategory"];
    self.price = [jsonDict objectForKey:@"price"];
    self.eventName = [jsonDict objectForKey:@"eventName"];
    self.eventName = [jsonDict objectForKey:@"eventName"];
    self.eventName = [jsonDict objectForKey:@"eventName"];
    self.eventName = [jsonDict objectForKey:@"eventName"];
    
}

@end

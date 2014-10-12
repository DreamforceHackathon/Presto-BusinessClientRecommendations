//
//  EPEventPackage.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/12/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "eventName": "John",
 "category": "Doe",
 "subCategory": "Doe",
 "price": "value",
 "image": "value",
 "time": "value",
 "location": "value",

 */
@interface EPEventPackage : NSObject

@property (nonatomic, strong) NSDictionary* jsonPackage;

@property (nonatomic, strong) NSString* eventName;
@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSString* subCategory;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* location;


- (instancetype)initWithDictionary: (NSDictionary* ) jsonDict;

@end

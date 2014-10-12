//
//  SFContact.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFContact : NSObject

@property (nonatomic, strong) NSDictionary* contactDetails;
@property (nonatomic, strong) NSString* strImgUrl;
@property (nonatomic, strong) NSArray* interestsList;
@end

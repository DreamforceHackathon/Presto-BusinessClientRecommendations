//
//  SFContact.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "SFContact.h"

@implementation SFContact

-(instancetype) init
{
    self = [super init];
    
    [self parseAndInitialize];
    return  self;
}

- (void) parseAndInitialize
{
    
    if(self.contactDetails == nil)
        return;
    
    NSString* interestString =     [self.contactDetails objectForKey:@"Description"];
    
    self.interestsList = [interestString componentsSeparatedByString:@","];
    
    self.strImgUrl = [self.contactDetails objectForKey:@"AssistantName"];
    
    

    
    
}

@end

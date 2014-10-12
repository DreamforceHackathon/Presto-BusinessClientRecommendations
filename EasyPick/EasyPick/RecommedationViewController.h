//
//  RecommedationViewController.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/12/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardScrollView.h"
#import "EPSearchFilter.h"
#import "SFContact.h"

@interface RecommedationViewController : UIViewController<CardScrollViewDelegate>

@property (nonatomic, strong) EPSearchFilter* searchFilter;
@property (nonatomic, strong) SFContact* selectedContact;
@property (nonatomic, strong) NSMutableArray* packageList;
@property (nonatomic, assign) NSInteger selectedPage;

@end


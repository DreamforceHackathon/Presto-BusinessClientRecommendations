//
//  EFContactDetailsViewController.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFContact.h"
@interface EFContactDetailsViewController : UITableViewController

@property (nonatomic, strong) SFContact* selectedSFContact;

@end

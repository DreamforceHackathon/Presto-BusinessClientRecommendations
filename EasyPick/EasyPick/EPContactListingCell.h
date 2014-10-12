//
//  EPContactListingCell.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface EPContactListingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgContactPhoto;

@property (weak, nonatomic) IBOutlet UILabel *lblContactFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblContactCompany;

@end

//
//  SwipeSelectionViewController.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFContact.h"
#import "DraggableViewBackground.h"

@interface EPStartRecommendationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SFContact* selectedContact;



@end

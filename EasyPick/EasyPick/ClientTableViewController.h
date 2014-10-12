//
//  ClientTableViewController.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface ClientTableViewController : UITableViewController <SFRestDelegate>


@property (nonatomic,strong)NSMutableArray *dataRows;


@end

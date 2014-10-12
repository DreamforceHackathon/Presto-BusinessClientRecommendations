//
//  SFCardPackageView.m
//  CardScrollViewSample
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 Alfonso Miranda Castro. All rights reserved.
//

#import "SFCardSinglePackageView.h"

@implementation SFCardSinglePackageView


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, 285, 300);
        self.imgCategoryOne.image = [UIImage imageNamed:@"headshot-generic.jpg"];
        
        [self.labelEventOne sizeToFit];
        self.autoresizesSubviews = YES;

        
    }
    return self;
}
@end

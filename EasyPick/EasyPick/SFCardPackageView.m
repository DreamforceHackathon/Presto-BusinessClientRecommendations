//
//  SFCardPackageView.m
//  CardScrollViewSample
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 Alfonso Miranda Castro. All rights reserved.
//

#import "SFCardPackageView.h"

@implementation SFCardPackageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.descriptionLabel.text = @"localised string"
        self.frame = CGRectMake(0, 0, 285, 300);
        self.imgCategoryOne.image = [UIImage imageNamed:@"headshot-generic.jpg"];
        self.imgCategoryTwo.image = [UIImage imageNamed:@"headshot-generic.jpg"];
        
        [self.lblEventTwo sizeToFit];
        [self.labelEventOne sizeToFit];
        self.autoresizesSubviews = YES;

        
    }
    return self;
}
@end

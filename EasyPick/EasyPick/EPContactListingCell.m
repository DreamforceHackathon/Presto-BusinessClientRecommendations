//
//  EPContactListingCell.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "EPContactListingCell.h"

@interface EPContactListingCell ()
@end


@implementation EPContactListingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Helpers
        self.imgContactPhoto.layer.cornerRadius = self.imgContactPhoto.frame.size.width / 2;
        self.imgContactPhoto.clipsToBounds = YES;
        self.imgContactPhoto.layer.borderWidth = 0.4f;
        self.imgContactPhoto.layer.borderColor = [UIColor grayColor].CGColor;
        //    cell.imgContactPhoto.layer.cornerRadius = 10.0f;

//        CGSize size = self.contentView.frame.size;
        /*
        // Initialize Main Label
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width - 16.0, size.height - 16.0)];
        
        // Configure Main Label
        [self.mainLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
        [self.mainLabel setTextAlignment:NSTextAlignmentCenter];
        [self.mainLabel setTextColor:[UIColor orangeColor]];
        [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Add Main Label to Content View
        [self.contentView addSubview:self.mainLabel];
         */
        
        
    }
    
    return self;
}
@end

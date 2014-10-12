//
//  HorizontalCardScrollView.h
//  EasyPick
//
//  Created by Mahesh Kumar on 10/12/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CardScrollView;

@protocol CardScrollViewDelegate <NSObject>

@optional

- (void)pagingScrollView:(CardScrollView *)pagingScrollView scrolledToPage:(NSInteger)currentPage;

@end

@interface CardScrollView : UIView <UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    NSArray *_sliderViews;
    NSInteger _lastContentOffset;
    CGFloat _offSet;
    NSInteger _slidePosition;
    CGSize _cardSize;
    CGPoint _cardPosition;
    CGFloat _offsetCurrentView;
    UIPageControl *_pageControl;
    
}

@property(nonatomic, assign) id<CardScrollViewDelegate> delegate;

- (id)initWithViews:(NSArray *)views atPoint:(CGPoint)point;

@end

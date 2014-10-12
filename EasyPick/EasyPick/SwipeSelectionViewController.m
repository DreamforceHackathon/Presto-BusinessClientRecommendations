//
//  SwipeSelectionViewController.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "SwipeSelectionViewController.h"

@interface SwipeSelectionViewController ()

@end

@implementation SwipeSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    [self.view addSubview:draggableBackground];
     */
    
    CGRect frame = self.view.frame;
    frame.origin.y = -self.view.frame.size.height; //optional: if you want the view to drop down
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:frame];
    draggableBackground.alpha = 0; //optional: if you want the view to fade in
    
    [self.view addSubview:draggableBackground];
    
    //optional: animate down and in
    [UIView animateWithDuration:0.5 animations:^{
        draggableBackground.center = self.view.center;
        draggableBackground.alpha = 1;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

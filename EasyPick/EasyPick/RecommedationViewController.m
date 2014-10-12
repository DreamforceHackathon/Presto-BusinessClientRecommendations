//
//  RecommedationViewController.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/12/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "RecommedationViewController.h"
#import "SFCardPackageView.h"
#import "EPConstants.h"
#import "AFNetworking.h"
#import "EPEventPackage.h"

@interface RecommedationViewController ()

@property (nonatomic, strong) NSMutableArray* arrPackage;

@end

@implementation RecommedationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableDictionary* dict1 = [[NSMutableDictionary alloc]init];
    /*
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *headerView = [nibContents lastObject];
    [headerView setBackgroundColor:[UIColor grayColor]];
    
    NSArray *nibContents1 = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *view1 = [nibContents1 lastObject];
    [view1 setBackgroundColor:[UIColor grayColor]];
    
    NSArray *nibContents2 = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *view2 = [nibContents2 lastObject];
    [view2 setBackgroundColor:[UIColor grayColor]];

    NSArray *views  = [[NSArray alloc] initWithObjects:headerView, view1, view2, nil];
    
    CardScrollView *cardScroll = [[CardScrollView alloc] initWithViews:views atPoint:CGPointMake(0, 75)];
    cardScroll.delegate = self;
    
    [self.view addSubview:cardScroll];
    
    
//    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor darkGrayColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
     */
    
    
    [self fetchPackages];


}
/*
 
 {
 "package": [
 {
 "eventName": "John",
 "category": "Doe",
 "subCategory": "Doe",
 "price": "value",
 "image": "value",
 "time": "value",
 "location": "value",
 "metadata": {
 "key1": "value",
 "key2": "value",
 "key3": "value",
 "key4": "value",
 "key5": "value",
 "key6": "value"
 }
 },
 {
 "eventName": "John",
 "category": "Doe",
 "subCategory": "Doe",
 "price": "value",
 "image": "value",
 "time": "value",
 "location": "value",
 "metadata": {
 "key1": "value",
 "key2": "value",
 "key3": "value",
 "key4": "value",
 "key5": "value",
 "key6": "value"
 }
 }
 ]
 }

 */
- (void) fetchPackages
{
    
    [self loadPackagesToPages];
    return;
    
    //construct baseURL
    //zip, date, budget, 10 Oct, 2014
    
//    NSString* sZip = self.searchFilter
//    static NSString * const SH_API_REQ_FORMAT = @"http://dforce-hack.herokuapp.com/wrapper.php?zip=%@&date=%@&budget=%@";

    NSString *string        = [NSString stringWithFormat:SH_API_REQ_FORMAT, @"", self.searchFilter.txtDate, self.searchFilter.txtBudget];
    NSURL *url              = [NSURL URLWithString:string];
    NSURLRequest *request   = [NSURLRequest requestWithURL:url];
    
    //Setup AFHTTP operation
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* packageList = (NSDictionary *)responseObject;
        NSLog(@"%@", packageList);
        
        NSArray* packages       = [responseObject objectForKey:@"packages"];
        
        for (NSDictionary* package in packages) {
            
            EPEventPackage* pkgObject = [[EPEventPackage alloc]initWithDictionary:package];
            [self.arrPackage addObject:pkgObject];
            
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //HTTP reqeust failed
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Packages Contacts List"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        NSLog(@"ContactsTableViewController:fetchPackages failed: %@", error.debugDescription);
        [alertView show];
    }];
    
    [operation start];
    
}

- (void) loadPackagesToPages2
{
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *headerView = [nibContents lastObject];
    [headerView setBackgroundColor:[UIColor grayColor]];
    
    NSArray *nibContents1 = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *view1 = [nibContents1 lastObject];
    [view1 setBackgroundColor:[UIColor grayColor]];
    
    NSArray *nibContents2 = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *view2 = [nibContents2 lastObject];
    [view2 setBackgroundColor:[UIColor grayColor]];
    
    NSArray *views  = [[NSArray alloc] initWithObjects:headerView, view1, view2, nil];
    
    CardScrollView *cardScroll = [[CardScrollView alloc] initWithViews:views atPoint:CGPointMake(0, 75)];
    cardScroll.delegate = self;
    
    [self.view addSubview:cardScroll];
    
    
    //    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor darkGrayColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}


- (void) loadPackagesToPages
{
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *headerView = [nibContents lastObject];
    [headerView setBackgroundColor:[UIColor grayColor]];

    
    NSArray *nibContents1 = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *view1 = [nibContents1 lastObject];
    [view1 setBackgroundColor:[UIColor grayColor]];
    
    NSArray *nibContents2 = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:nil options:nil];
    SFCardPackageView *view2 = [nibContents2 lastObject];
    [view2 setBackgroundColor:[UIColor grayColor]];
    
    NSArray *views  = [[NSArray alloc] initWithObjects:headerView, view1, view2, nil];
    
    CardScrollView *cardScroll = [[CardScrollView alloc] initWithViews:views atPoint:CGPointMake(0, 75)];
    cardScroll.delegate = self;
    
    [self.view addSubview:cardScroll];
    
    
    //    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor darkGrayColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
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


#pragma -
#pragma CardScrollViewDelegate

- (void)pagingScrollView:(CardScrollView *)pagingScrollView scrolledToPage:(NSInteger)currentPage {
    
    self.selectedPage = currentPage;
    NSLog(@"%d", currentPage);
    
}


@end

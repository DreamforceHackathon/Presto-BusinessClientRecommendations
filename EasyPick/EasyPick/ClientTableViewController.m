//
//  ClientTableViewController.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "ClientTableViewController.h"
#import "EPContactListingCell.h"
#import "EPStartRecommendationViewController.h"
#import "EFContactDetailsViewController.h"
#import "RecommedationViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ClientTableViewController ()

@property SFContact* selectedContact;
@end

@implementation ClientTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Salesforce Contacts";
    self.selectedContact = nil;
    self.tableView.delegate = self;
    
    //Here we use a query that should work on either Force.com or Database.com
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Name, Account.Name, Description, AssistantName  FROM Contact LIMIT 20"];
//    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Name  FROM User LIMIT 10"];
    [[SFRestAPI sharedInstance] send:request delegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {

    NSArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %lu", (unsigned long)records.count);
    self.dataRows = records.mutableCopy;
    
    NSArray *items = [@"a:1,b:2,c:3" componentsSeparatedByString:@","];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (void)parseCSVToMutableMap{
    
}


- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     EPContactListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactListingCell" forIndexPath:indexPath];
     */
    static NSString *CellIdentifier = @"ContactListingCell";
    
    // Dequeue or create a cell of the appropriate type.
    EPContactListingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (EPContactListingCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    cell.imgContactPhoto.layer.cornerRadius = cell.imgContactPhoto.frame.size.width / 2;
    cell.imgContactPhoto.clipsToBounds = YES;
    cell.imgContactPhoto.layer.borderWidth = 0.4f;
    cell.imgContactPhoto.layer.borderColor = [UIColor grayColor].CGColor;

    
    NSDictionary *obj = [self.dataRows objectAtIndex:indexPath.row];

    NSString* urlStr = [obj objectForKey:@"AssistantName"];
    NSLog(@"Assistant : %@", urlStr);
     if (urlStr == nil || [urlStr isKindOfClass:[NSNull class]])
    {
        urlStr =@"http://www.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0008_clear_sky_night.png";

    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"headshot-generic.jpg"];
    
    __weak EPContactListingCell *weakCell = cell;
    
    [cell.imgContactPhoto setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       

                                       weakCell.imgContactPhoto.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    //cell.imgContactPhoto.image = [UIImage imageNamed:@"Jonathan.Ive.jpg"];
    
    //;
    /*
    cell.lblContactCompany.text = @"Jonathan Ive";
    cell.lblContactCompany.text = @"Apple Inc.";
     */
    // Configure the cell to show the data.
    
    cell.lblContactFullName.text = [obj objectForKey:@"Name"];
    
    cell.lblContactCompany.text = @"Apple Inc.";
    
    NSDictionary *obj1 = [obj objectForKey:@"Account"];
    NSString* strAccountName = [obj1 objectForKey:@"Name"];
    
    NSLog(@"ACCOUNTNAME : %@", strAccountName);
    
    NSString* img = [obj objectForKey:@"Description"];
    NSLog(@"Description : %@", img);
    
    
    if(strAccountName != nil)
        cell.lblContactCompany.text = strAccountName;
    else
        cell.lblContactCompany.text = @"Apple Inc.";
    
    
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.selectedContact = nil;
    self.selectedContact = [[SFContact alloc]init];
    self.selectedContact.contactDetails = [self.dataRows objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier: @"showContactDetails" sender: [tableView cellForRowAtIndexPath: indexPath]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedContact = nil;
    self.selectedContact = [[SFContact alloc]init];

    self.selectedContact.contactDetails = [self.dataRows objectAtIndex:indexPath.row];
    self.selectedContact.strImgUrl = [self.selectedContact.contactDetails objectForKey:@"AssistantName"];
    self.selectedContact.interestsList = [self.selectedContact.contactDetails objectForKey:@"Description"];
    [self performSegueWithIdentifier: @"showRecommendationConfig" sender: [tableView cellForRowAtIndexPath: indexPath]];
    
    
//    @property (nonatomic, strong) NSString* strImgUrl;
 //   @property (nonatomic, strong) NSArray* interestsList;

    
   // [self performSegueWithIdentifier: @"showRecommendation" sender: [tableView cellForRowAtIndexPath: indexPath]];
 //   [self performSegueWithIdentifier: @"showRecommendationConfig" sender: [tableView cellForRowAtIndexPath: indexPath]];
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

    
    if ([segue.identifier isEqualToString:@"showContactDetails"]) {
        EFContactDetailsViewController* vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        vc.selectedSFContact = self.selectedContact;
        
    }else
    if ([segue.identifier isEqualToString:@"showRecommendation"]) {
        RecommedationViewController* vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        vc.selectedSFContact = self.selectedContact;
        
    }
    else if ([segue.identifier isEqualToString:@"showRecommendationConfig"]) {
        
        UINavigationController* vcNav = [segue destinationViewController];
        
        EPStartRecommendationViewController* vc = [vcNav.viewControllers firstObject];
       // NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
                vc.selectedContact = self.selectedContact;
        
    }
    
    
    
    
}

@end

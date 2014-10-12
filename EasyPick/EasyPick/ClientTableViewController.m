//
//  ClientTableViewController.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "ClientTableViewController.h"
#import "EPContactListingCell.h"
#import "SwipeSelectionViewController.h"
#import "EFContactDetailsViewController.h"

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
    
    //Here we use a query that should work on either Force.com or Database.com
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Name, Account.Name  FROM Contact LIMIT 10"];
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
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
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

    
    cell.imgContactPhoto.image = [UIImage imageNamed:@"Jonathan.Ive.jpg"];
    /*
    cell.lblContactCompany.text = @"Jonathan Ive";
    cell.lblContactCompany.text = @"Apple Inc.";
     */
    // Configure the cell to show the data.
    NSDictionary *obj = [self.dataRows objectAtIndex:indexPath.row];
    cell.lblContactFullName.text = [obj objectForKey:@"Name"];
    
//    cell.lblContactCompany.text = @"Apple Inc.";
    cell.lblContactCompany.text = [obj objectForKey:@"Account"];
    
    
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

    
    if ([segue.identifier isEqualToString:@"showContactDetails"]) {
        EFContactDetailsViewController* vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        vc.selectedSFContact = self.selectedContact;
        
    }
    
}

@end

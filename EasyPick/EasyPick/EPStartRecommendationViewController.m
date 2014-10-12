//
//  SwipeSelectionViewController.m
//  EasyPick
//
//  Created by Mahesh Kumar on 10/11/14.
//  Copyright (c) 2014 iSource. All rights reserved.
//

#import "EPStartRecommendationViewController.h"
#import "RecommedationViewController.h"
#import "EPSearchFilter.h"
#import "UIImageView+AFNetworking.h"


@interface EPStartRecommendationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableConfigView;
@property (weak, nonatomic) IBOutlet UIImageView *imgContact;

@property (weak, nonatomic) IBOutlet UILabel *lblContactName;
@property (weak, nonatomic) UITextView* txtDate;
@property (weak, nonatomic) UITextView* txtBudget;
@property (weak, nonatomic) UITextView* txtFrom;
@property (weak, nonatomic) UITextView* txtTo;
@property (weak, nonatomic) UITextView* txtCity;


@property (weak, nonatomic) UIImageView* imgBudget;
@property (weak, nonatomic) UIImageView* imgDate;
@property (weak, nonatomic) UIImageView* imgTime;
@property (weak, nonatomic) UIImageView* imgCity;


- (IBAction)onClickOutside:(id)sender;


///PackageList
//CurrentPage -> array index
//Seleciton Criteria

//CHoose -> pass on the package info , user info to the next page.



@end

@implementation EPStartRecommendationViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableConfigView.dataSource = self;
    self.txtDate = nil;
    
   // self.tableConfigView.delegate = self;
    CGRect headerFrame           = self.tableConfigView.tableHeaderView.frame;
    headerFrame.size.height      = 0;

    self.tableConfigView.tableHeaderView.frame            = headerFrame;
    
    self.tableConfigView.tableHeaderView = self.tableConfigView.tableHeaderView;
    
  //  self.tableConfigView.tableFooterView.hidden = YES;
   // self.tableConfigView.tableHeaderView.hidden = YES;
    

    NSString* strUrl = self.selectedContact.strImgUrl;
    
    self.imgContact.layer.cornerRadius =     self.imgContact.frame.size.width / 2;
        self.imgContact.clipsToBounds = YES;
        self.imgContact.layer.borderWidth = 0.4f;
        self.imgContact.layer.borderColor = [UIColor grayColor].CGColor;
    

    NSURL *url = [NSURL URLWithString:strUrl];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"headshot-generic.jpg"];
    self.lblContactName.text = [self.selectedContact.contactDetails objectForKey:@"Name"];
    
    __weak typeof(self) _weakSelf = self;
    
    [self.imgContact setImageWithURLRequest:request
                                placeholderImage:placeholderImage
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                             
                                             
                                             _weakSelf.imgContact.image = image;

                                             [_weakSelf.view setNeedsLayout];
                                             
                                         } failure:nil];

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
 //   if ([sender isEqual:mailTf])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = nil;
    if(indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstConfigRow"];
        self.imgBudget = [cell viewWithTag:1001];
        self.txtBudget = [cell viewWithTag:1002];
        
        
    }else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondConfigRow"];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
         datePicker.tag = indexPath.row;//1
        
        self.txtDate = [cell viewWithTag:1004];
        self.txtDate.inputView = datePicker;
        
        self.imgDate = [cell viewWithTag:1003];

        ///Set current date
/*        NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/YYYY" options:0
                                                                  locale:[NSLocale currentLocale]];*/
        NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"dd MMM, YYYY" options:0
                                                                  locale:[NSLocale currentLocale]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatString];
        
        NSString *todayString = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"todayString: %@", todayString);
        self.txtDate.text = todayString;
        
        
    }else if (indexPath.row == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"thirdConfigRow"];
        self.imgTime = [cell viewWithTag:1005];
        self.txtFrom = [cell viewWithTag:1006];
        self.txtTo = [cell viewWithTag:1008];
        
        ////////
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = indexPath.row; //2
        self.txtFrom.inputView = datePicker;
        
        NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"HH:mm" options:0
                                                                  locale:[NSLocale currentLocale]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatString];
        
        NSString *todayString = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"todayString: %@", todayString);
        self.txtFrom.text = todayString;
        /////////////////
        
        
        UIDatePicker *datePicker1 = [[UIDatePicker alloc] init];
        datePicker1.datePickerMode = UIDatePickerModeTime;
        [datePicker1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker1.tag = indexPath.row + 1;//3
        self.txtTo.inputView = datePicker1;
        
        
        [dateFormatter setDateFormat:formatString];
        
        todayString = [dateFormatter stringFromDate:[[NSDate date]dateByAddingTimeInterval:60*60]];
        NSLog(@"todayString: %@", todayString);
        self.txtTo.text = todayString;
        

    }else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"fourthConfigRow"];
        
        self.txtCity = [cell viewWithTag:1010];
        self.imgCity = [cell viewWithTag:1009];
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)datePickerValueChanged:(id)sender{
    
    if(self.txtDate == nil)
        return;
    
    UIDatePicker* datePicker = sender;
    
    NSDate* date = datePicker.date;
    
    
    
    if(datePicker.tag == 1)
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/YYYY"];
        [self.txtDate setText:[df stringFromDate:date]];
        
    }
    if(datePicker.tag == 2)
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm"];
        [self.txtTo setText:[df stringFromDate:date]];
        
    }
    if(datePicker.tag == 3)
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm"];
        [self.txtTo setText:[df stringFromDate:date]];
        
    }
}
//showRecommendation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
        if ([segue.identifier isEqualToString:@"showRecommendation"]) {
            RecommedationViewController* vc = [segue destinationViewController];
            vc.selectedContact = self.selectedContact;
            
            
            EPSearchFilter* searchFilter = [[EPSearchFilter alloc]init];
            searchFilter.txtBudget = self.txtBudget.text;
            searchFilter.txtCity = self.txtCity.text;
            searchFilter.txtDate = self.txtDate.text;
            searchFilter.txtTimeFrom = self.txtFrom.text;
            searchFilter.txtTimeTo = self.txtTo.text;
            vc.searchFilter = searchFilter;
            
            
            
        }
    
    
    
    
}




- (IBAction)onClickOutside:(id)sender {
}
@end

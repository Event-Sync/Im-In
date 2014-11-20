//
//  ActivityTabViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ActivityTabViewController.h"
#import "Activity.h"
#import "ActivityTableViewCell.h"
#import "NetworkController.h"
#import "NewActivityViewController.h"
#import "ViewActivityViewController.h"
#import "MenuViewController.h"


@interface ActivityTabViewController () 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *activities;
@property (strong, nonatomic) NSArray *filteredActivities;

@end

@implementation ActivityTabViewController

- (IBAction)segmentedControlPressed:(UISegmentedControl *)sender {
    
    NSPredicate *upcoming = [NSPredicate predicateWithFormat:@"eventExpired == %@", [NSNumber numberWithBool:NO]];
    NSPredicate *past = [NSPredicate predicateWithFormat:@"eventExpired == %@", [NSNumber numberWithBool:YES]];
    NSArray *newArray = [NSArray arrayWithArray:_activities];

    if (sender.selectedSegmentIndex == 0) {
        _filteredActivities = [newArray filteredArrayUsingPredicate:upcoming];
    } else {
        _filteredActivities = [newArray filteredArrayUsingPredicate:past];
    }
    
    NSLog(@"%lu", (unsigned long) _filteredActivities.count);
    
    [_tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newEventButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    self.title = @"Activities";
    
    // load activities array
    
    [[NetworkController sharedInstance] fetchAllEventsUsingPath:^(NSError *error, NSMutableArray *response) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            _activities = response;
            
            NSPredicate *upcoming = [NSPredicate predicateWithFormat:@"eventExpired == %@", [NSNumber numberWithBool:NO]];
            NSArray *newArray = [NSArray arrayWithArray:_activities];
            _filteredActivities = [newArray filteredArrayUsingPredicate:upcoming];
        }
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
    if (!authToken) {
        MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MENU_VC"];
        [self presentViewController:menuVC animated:0 completion:nil];
        
    }
}

- (void) newEventButtonPressed {
    NSLog(@"Add button pressed");
    NewActivityViewController *newEventVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NEWEVENT_VC"];
    [self.navigationController pushViewController:newEventVC animated:true];
    //[self presentViewController:newEventVC animated:true completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filteredActivities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    Activity *newActivity = _filteredActivities[indexPath.row];
    cell.textLabel.text = newActivity.eventDescription;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ViewActivityViewController *viewEventVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VIEWEVENT_VC"];
    [self.navigationController pushViewController:viewEventVC animated:true];
    
}



@end

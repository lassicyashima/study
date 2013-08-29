//
//  CalenderViewViewController.m
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import "CalenderViewController.h"
#import "Schedule.h"

@interface Today : NSObject
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

- (BOOL) isTodayWithMonth:(NSInteger)month day:(NSInteger)day;

@end

@implementation Today

- (BOOL)isTodayWithMonth:(NSInteger)month day:(NSInteger)day
{
    return (self.month == month && self.day == day);
}

@end

@interface CalenderViewController ()
{
    NSCalendar *calendar;
    NSDateComponents *dateComp;
    Today *today;
}
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, strong) UIPopoverController *popController;
@property NSMutableDictionary *schedule;
@end

@implementation CalenderViewController

- (void)viewDidLoad
{
    // ViewDidLoad is called Only Once on First.
    [super viewDidLoad];
    
    self.title = @"Schedole";
    NSDate *now = [NSDate date];
    calendar = [NSCalendar currentCalendar];
    dateComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                           fromDate:now];
    today = [Today new];
    today.day   = dateComp.day;
    today.month = dateComp.month;
    self.days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now].length;
    id obj = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [obj managedObjectContext];
    self.schedule = @{}.mutableCopy;
}

#pragma mark - TableView Dalegate and DataSouce

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d月", [dateComp month]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.days;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath has row and section.
    static NSString *cellIdentifier = @"CalendorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:cellIdentifier];
    }
    
    NSInteger day = indexPath.row + 1;

    UILabel *dateLabel   = (UILabel *)[cell viewWithTag:1];
    UILabel *actionLabel = (UILabel *)[cell viewWithTag:2];
    
    dateLabel.text = [NSString stringWithFormat:@"%d/%d/%d",
                      dateComp.year,
                      dateComp.month,
                      day];
    actionLabel.text = self.schedule[dateLabel.text];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger day = indexPath.row + 1;
    if ([today isTodayWithMonth:[dateComp month] day:day]) {
        UILabel *dateLabel   = (UILabel *)[cell viewWithTag:1];
        UILabel *actionLabel = (UILabel *)[cell viewWithTag:2];
        dateLabel.textColor = [UIColor whiteColor];
        actionLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor redColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // NOT USE.
//    static NSString *cellIdentifier = @"CalendorCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:cellIdentifier];
//    }
    
    NSString *str = [NSString stringWithFormat:@"%d/%d/%d",
                     dateComp.year,
                     dateComp.month,
                     indexPath.row + 1];
    NSLog(@"cell touched. section:%d , row:%d" , indexPath.section , indexPath.row);
    NSLog(@"alertView title:%@" , str);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str
                                                    message:@"スケジュールを入力してくれい"
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"OK", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

#pragma mark - AlertView Delegate

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        NSLog(@"%@" , [alertView textFieldAtIndex:0].text);
        self.schedule[alertView.title] = [alertView textFieldAtIndex:0].text;
        [self insertNewObjectWithDate:alertView.title message:[alertView textFieldAtIndex:0].text];
        self.fetchedResultsController = nil;
        [self setScheduleFromCoreData];
    }
    NSLog(@"%@" , self.schedule);
    [self.tableView reloadData];
}

#pragma mark - Shake Gesture

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionEnded");
    [self addButtonTouched:self.navigationItem.leftBarButtonItem];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled");
}

#pragma mark - ButtonClicked Event Method

- (void)addButtonTouched:(id)sender
{
    NSString *storyboardFile = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
    MyPopOverViewController *controller = [[UIStoryboard storyboardWithName:storyboardFile bundle:nil] instantiateViewControllerWithIdentifier:@"MyPopOverView"];
    controller.delegate = self;
    self.popController = [[UIPopoverController alloc] initWithContentViewController:controller];
    [self.popController presentPopoverFromBarButtonItem:sender
                               permittedArrowDirections:UIPopoverArrowDirectionAny
                                               animated:YES];
}

#pragma mark - MyPopOverViewContorollerDelegate Method

- (void)popOverButtonTouched:(UIButton *)button
{
    NSLog(@"touched button:button%d"  , button.tag);
    [self.popController dismissPopoverAnimated:YES];
    
    [dateComp setMonth:button.tag];
    self.days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[calendar dateFromComponents:dateComp]].length;
    [dateComp setDay:rand() % self.days];
    [self.tableView reloadData];
}

#pragma mark - Core Data

- (void)insertNewObjectWithDate:(NSString *)dateString message:(NSString *)message
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Schedule *newSchedule = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setDateFormat:@"yyyy/M/d"];
    NSDate *inputDate = [inputDateFormatter dateFromString:dateString];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    newSchedule.created_time = [NSDate date];
    newSchedule.date =  inputDate;
    newSchedule.action = message;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:100];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_time" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Schedule"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    return _fetchedResultsController;
}

#pragma mark - set Schedule Dictionary Method

- (void)setScheduleFromCoreData
{
    int i = 0;
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setDateFormat:@"yyyy/M/d"];
    for ( Schedule *scheduleData in [self.fetchedResultsController fetchedObjects] ){
        NSLog(@"index:%d action:%@" ,i ,scheduleData.action);
        NSString *key = [inputDateFormatter stringFromDate:scheduleData.date];
        self.schedule[key] = scheduleData.action;
        i++;
    }
}

@end

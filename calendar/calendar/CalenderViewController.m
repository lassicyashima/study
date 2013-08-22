//
//  CalenderViewViewController.m
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import "CalenderViewController.h"

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
@end

@implementation CalenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *now = [NSDate date];
    calendar = [NSCalendar currentCalendar];
    dateComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                           fromDate:now];
    today = [Today new];
    today.day   = dateComp.day;
    today.month = dateComp.month;
    self.days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now].length;
}

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
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier];
    }
    
    NSInteger day = indexPath.row + 1;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d/%d/%d",
                           dateComp.year,
                           dateComp.month,
                           day];    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger day = indexPath.row + 1;
    if ([today isTodayWithMonth:[dateComp month] day:day]) {
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
}

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

- (void)popOverButtonTouched:(UIButton *)button
{
    NSLog(@"touched button:%@" , button);
    [self.popController dismissPopoverAnimated:YES];
    
    [dateComp setMonth:button.tag];
    self.days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[calendar dateFromComponents:dateComp]].length;
    [dateComp setDay:rand() % self.days];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier];
    }
    
    NSInteger day = indexPath.row + 1;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d/%d/%d",
                           dateComp.year,
                           dateComp.month,
                           day];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cell.textLabel.text
                                                    message:@"スケジュールを入力してくれい"
                                                   delegate:nil
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
    
}

@end

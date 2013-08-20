//
//  CalenderViewViewController.m
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import "CalenderViewController.h"

@interface CalenderViewController ()
{
    NSDate *now;
    NSCalendar *calendar;
    NSDateComponents *dateComp;
}
@end

@implementation CalenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    now = [NSDate date];
    calendar = [NSCalendar currentCalendar];
    dateComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                           fromDate:now];
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
    return [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now].length;
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
    
    NSInteger today = dateComp.day;
    
    if (day == today) {
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger today = dateComp.day;
    
    NSInteger day = indexPath.row + 1;
    
    if (day == today) {
        cell.backgroundColor = [UIColor redColor];
    }
    
}

@end

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
@property NSMutableDictionary *schedule;
@end

@implementation CalenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    now = [NSDate date];
    calendar = [NSCalendar currentCalendar];
    dateComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                           fromDate:now];
    self.schedule = @{}.mutableCopy;
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:cellIdentifier];
    }
    
    NSInteger day = indexPath.row + 1;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d/%d/%d",
                           dateComp.year,
                           dateComp.month,
                           day];
    cell.detailTextLabel.text = self.schedule[cell.textLabel.text];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    NSInteger day = indexPath.row + 1;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d/%d/%d",
                           dateComp.year,
                           dateComp.month,
                           day];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cell.textLabel.text
                                                    message:@"スケジュールを入力してくれい"
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"OK", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        NSLog(@"%@" , [alertView textFieldAtIndex:0].text);
        self.schedule[alertView.title] = [alertView textFieldAtIndex:0].text;
    }
    [self.tableView reloadData];
}

@end

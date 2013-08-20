//
//  ClockViewController.m
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import "ClockViewController.h"

@implementation ClockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(driveClock:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)driveClock:(NSTimer *)timer
{
    NSDate *today = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *todayComp = [calendar components:flags fromDate:today];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                           [todayComp hour],
                           [todayComp minute],
                           [todayComp second]];
}

@end

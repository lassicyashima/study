//
//  Schedule.h
//  calendar
//
//  Created by taketa on 2013/08/22.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * action;
@property (nonatomic, retain) NSNumber * validity;
@property (nonatomic, retain) NSDate * created_time;

@end

//
//  CalenderViewViewController.h
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MyPopOverViewController.h"

@interface CalenderViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UINavigationBarDelegate , MyPopPverViewDelegate , NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

- (IBAction)addButtonTouched:(id)sender;

@end

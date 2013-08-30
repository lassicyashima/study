//
//  MyPopOverViewController.m
//  calendar
//
//  Created by taketa on 2013/08/21.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import "MyPopOverViewController.h"

@interface MyPopOverViewController ()

@end

@implementation MyPopOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // ViewDidLoad is called Only Once on First.
    [super viewDidLoad];
    [self.button1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button4 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button5 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button6 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button7 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button8 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button9 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button10 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button11 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.button12 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - set Button Methods

- (void)buttonTouched:(id)sender
{
    [_delegate popOverButtonTouched:(UIButton *)sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

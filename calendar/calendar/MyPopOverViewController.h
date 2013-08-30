//
//  MyPopOverViewController.h
//  calendar
//
//  Created by taketa on 2013/08/21.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyPopPverViewDelegate <NSObject>

- (void) popOverButtonTouched:(UIButton *)button;

@end

@interface MyPopOverViewController : UIViewController
{
    __weak id <MyPopPverViewDelegate> _delegate;
}
@property (nonatomic,weak) id <MyPopPverViewDelegate> delegate;
@property (nonatomic,weak) IBOutlet UIButton* button1;
@property (nonatomic,weak) IBOutlet UIButton* button2;
@property (nonatomic,weak) IBOutlet UIButton* button3;
@property (nonatomic,weak) IBOutlet UIButton* button4;
@property (nonatomic,weak) IBOutlet UIButton* button5;
@property (nonatomic,weak) IBOutlet UIButton* button6;
@property (nonatomic,weak) IBOutlet UIButton* button7;
@property (nonatomic,weak) IBOutlet UIButton* button8;
@property (nonatomic,weak) IBOutlet UIButton* button9;
@property (nonatomic,weak) IBOutlet UIButton* button10;
@property (nonatomic,weak) IBOutlet UIButton* button11;
@property (nonatomic,weak) IBOutlet UIButton* button12;

@end

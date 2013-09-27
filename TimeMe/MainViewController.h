//
//  ViewController.h
//  TimeMe
//
//  Created by Omar Khulusi on 9/20/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMIntervalTimer.h"

@interface MainViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *totalTimePickerLabel;
@property (nonatomic, strong) UIPickerView *totalTimePickerView;

@property (nonatomic, strong) UILabel *pickerViewLabel;
@property (nonatomic, strong) UIPickerView *intervalPickerView;

@property (nonatomic, strong) TMIntervalTimer *timer;

@property (nonatomic, strong) UIButton *startButton;

@end

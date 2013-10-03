//
//  ViewController.h
//  TimeMe
//
//  Created by Omar Khulusi on 9/20/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMIntervalTimer.h"

@interface TMViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel *secLabel;
    UILabel *minLabel;
    UILabel *hourLabel;
    
    UILabel *totalTimePickerLabel;
    UIPickerView *totalTimePickerView;
    
    UILabel *pickerViewLabel;
    UIPickerView *intervalPickerView;
    
    TMIntervalTimer *timer;
    
    UIButton *timerToggleButton;
}

@end
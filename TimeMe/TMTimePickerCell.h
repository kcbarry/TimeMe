//
//  TMTimePickerCell.h
//  TimeMe
//
//  Created by Clark Barry on 10/4/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMTimePickerCell;

@protocol TMTimePickerDelegate <NSObject>
//returns the timeinterval that the picker should set itself to, return the time interval sent to keep the changes
- (NSTimeInterval)timePickerCell:(TMTimePickerCell *)timePickerCell didSetTimeInterval:(NSTimeInterval)timeInterval;
@end

@interface TMTimePickerCell : UITableViewCell<UIPickerViewDelegate,UIPickerViewDataSource>

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureForTimeInterval:(NSTimeInterval)timeInterval;
@property (weak) id<TMTimePickerDelegate>delegate;
@property (readonly) UIPickerView *pickerView;

@end

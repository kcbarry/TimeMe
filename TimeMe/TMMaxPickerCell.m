//
//  TMMaxPickerCell.m
//  Bzz
//
//  Created by Clark Barry on 11/15/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import "TMMaxPickerCell.h"
#import "TMTimePickerCell_Private.h"

@implementation TMMaxPickerCell

- (void)setMaxTimeInterval:(NSTimeInterval)maxTimeInterval {
    _maxTimeInterval = maxTimeInterval;
    self.maxHours = floor(maxTimeInterval/3600);
    if (self.maxHours == 0) {
        if (maxTimeInterval == 60) {
            self.maxMinutes = 0;
        } else {
            self.maxMinutes = (maxTimeInterval-self.maxHours*60)/60;
        }
    } else {
        self.maxMinutes = 60;
    }
}

@end

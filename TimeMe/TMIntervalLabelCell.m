//
//  TMIntervalLabelCell.m
//  TimeMe
//
//  Created by Clark Barry on 10/12/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import "TMIntervalLabelCell.h"
#import "TMStyleManager.h"
#import "NSString+TMTimeIntervalString.h"

@implementation TMIntervalLabelCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        TMStyleManager *styleManager = [TMStyleManager getInstance];
        [self setBackgroundColor:styleManager.backgroundColor];
        [self.textLabel setTextColor:styleManager.detailTextColor];
        [self.textLabel setHighlightedTextColor:styleManager.highlightDetailTextColor];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIImageView *checkView = [[UIImageView alloc] initWithImage:styleManager.checkImage];
        self.accessoryView = checkView;
        
    }
    return self;
}

- (void)configureForTimeInterval:(NSTimeInterval)timeInterval {
    NSString *intervalString = [NSString stringForTimeInterval:timeInterval style:TMTimeIntervalStringDigital];
    [self.textLabel setText:intervalString];
}

- (void)setChecked:(BOOL)checked animated:(BOOL)animated {
    
}

@end

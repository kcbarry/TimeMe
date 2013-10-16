//
//  TMTimerView.m
//  TimeMe
//
//  Created by Clark Barry on 10/10/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import "TMTimerView.h"
#import "TMStyleManager.h"
#import "TMAlertManager.h"

#define UPDATE_INTERVAL .05

@interface TMTimerView () {
    BOOL _updating;
    
    UILabel *_timerLabel;
    UILabel *_intervalLabel;
}

- (void)_updateLabels;
- (NSString *)_stringForElapsedTime:(NSTimeInterval)elapsedTime forLength:(NSTimeInterval)length;
@end

@implementation TMTimerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _updating = NO;
        
        TMStyleManager *styleManager = [TMStyleManager getInstance];
        CGRect labelFrame = CGRectMake(0, 0, frame.size.width, frame.size.height/2);
        _timerLabel = [[UILabel alloc] initWithFrame:labelFrame];
        [_timerLabel setTextAlignment:NSTextAlignmentCenter];
        [_timerLabel setFont:[styleManager.font fontWithSize:70]];
        [_timerLabel setTextColor:styleManager.textColor];
        [_timerLabel setHighlightedTextColor:styleManager.highlightTextColor];
        [_timerLabel setText:@"00:00:00"];
        [_timerLabel sizeToFit];
        [_timerLabel setFrame:CGRectMake(0, frame.size.height/2 - _timerLabel.frame.size.height,
                                         frame.size.width, _timerLabel.frame.size.height)];
        [self addSubview:_timerLabel];
        
        labelFrame = CGRectMake(0, frame.size.height/2, frame.size.width, frame.size.height/2);
        _intervalLabel = [[UILabel alloc] initWithFrame:labelFrame];
        [_intervalLabel setTextAlignment:NSTextAlignmentCenter];
        [_intervalLabel setTextColor:styleManager.textColor];
        [_intervalLabel setHighlightedTextColor:styleManager.highlightTextColor];
        [_intervalLabel setFont:[styleManager.font fontWithSize:60]];
        [_intervalLabel setText:@"00:00:00"];
        [self addSubview:_intervalLabel];
    }
    return self;
}

- (NSString *)_stringForElapsedTime:(NSTimeInterval)elapsedTime forLength:(NSTimeInterval)length {
    NSTimeInterval countdownTime = length - elapsedTime;
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDate *startDate = [[NSDate alloc] init];
    NSDate *endDate = [[NSDate alloc] initWithTimeInterval:countdownTime sinceDate:startDate];
    
    
    unsigned int conversionFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *components = [calender components:conversionFlags fromDate:startDate toDate:endDate options:0];
    NSString *intervalString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)[components hour],(long)[components minute],(long)[components second]];
    return intervalString;
}

- (void)setHighlighted:(BOOL)highlighted {
    TMStyleManager *styleManager = [TMStyleManager getInstance];
    UIColor *backgroundColor = highlighted ? styleManager.highlightBackgroundColor : styleManager.backgroundColor;
    [self setBackgroundColor:backgroundColor];
    [_timerLabel setHighlighted:highlighted];
    [_intervalLabel setHighlighted:highlighted];
}

- (void)beginUpdating {
    _updating = YES;
    [self _updateLabels];
}

- (void)_updateLabels {
    TMAlertManager *alertManager = [TMAlertManager getInstance];
    NSTimeInterval now = [[NSDate date] timeIntervalSinceReferenceDate];
    NSTimeInterval elapsedTimer = now - alertManager.timerStart;
    NSString *timerText = [self _stringForElapsedTime:elapsedTimer forLength:alertManager.timerLength];
    NSTimeInterval elapsedInterval = now - alertManager.intervalStart;
    NSString *intervalText = [self _stringForElapsedTime:elapsedInterval forLength:alertManager.intervalLength];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_timerLabel setText:timerText];
        [_intervalLabel setText:intervalText];
    });
    if (_updating) {
        [self performSelector:@selector(_updateLabels) withObject:nil afterDelay:UPDATE_INTERVAL];
    }
}

- (void)endUpdating {
    _updating = NO;
}


@end

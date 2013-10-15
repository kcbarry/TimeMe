//
//  TMAlertManager.m
//  TimeMe
//
//  Created by Clark Barry on 10/12/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import "TMAlertManager.h"
#import "NSMutableArray+TMFrontLoading.h"

#define TWO_MINUTES (2.*60.)
#define ONE_MINUTE (60.)
#define THIRTY_SECONDS (30.)
#define TEN_SECONDS (10.)

@interface TMAlertManager () {
    NSMutableArray *_scheduledAlerts;
}
- (NSArray *)_alertIntervalsForCountdown:(NSTimeInterval)countdown;
- (void)_alertDidFire:(NSNumber *)alertInterval;
@end

@implementation TMAlertManager



static TMAlertManager *__instance = nil;
+ (instancetype)getInstance {
    if (!__instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __instance = [[TMAlertManager alloc] init];
        });
    }
    return __instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _scheduledAlerts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)_alertIntervalsForCountdown:(NSTimeInterval)countdown {
    static NSArray *__baseTimes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __baseTimes = @[@TWO_MINUTES,@ONE_MINUTE, @THIRTY_SECONDS, @TEN_SECONDS];
    });
    NSMutableArray *alerts = [[NSMutableArray alloc] initWithCapacity:5];
    
    while (countdown/2. > TWO_MINUTES) {
        NSTimeInterval alertTime = (countdown/2.);
        alertTime = round(alertTime/15.0);
        alertTime = alertTime * 15;
        [alerts addObject:@(alertTime)];
        countdown = alertTime;
    }
    for (NSNumber *alertTime in __baseTimes) {
        if ([alertTime doubleValue] < countdown) {
            [alerts addObject:alertTime];
        }
    }
    return alerts;
}

- (void)setTimerLength:(NSTimeInterval)timerLength {
    _timerLength = timerLength;
    _alertIntervals = [self _alertIntervalsForCountdown:_timerLength];
}

- (void)_alertDidFire:(NSNumber *)alertInterval {
    NSLog(@"alertDidFire: %@",alertInterval);
    [_scheduledAlerts removeObject:alertInterval];
    if (![_scheduledAlerts count]) {
        NSLog(@"alertDidFire finished");
        //tell everyone we're done
    }
}

- (void)startAlerts:(NSArray *)alerts {
    _generatingAlerts = YES;
    for (NSNumber *alertTime in alerts) {
        NSTimeInterval delay = _timerLength - [alertTime doubleValue];
        [self performSelector:@selector(_alertDidFire:) withObject:alertTime afterDelay:delay];
        [_scheduledAlerts addObject:alertTime];
    }
    [self performSelector:@selector(_alertDidFire:) withObject:@(_timerLength) afterDelay:_timerLength];
    [_scheduledAlerts addObject:@(_timerLength)];

}

- (void)stopAlerts {
    _generatingAlerts = NO;
    [_scheduledAlerts removeAllObjects];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)scheduleAlertsForBackground {

}

- (void)cancelBackgroundAlerts {

}
@end

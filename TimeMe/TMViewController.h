//
//  ViewController.h
//  TimeMe
//
//  Created by Omar Khulusi on 9/20/13.
//  Copyright (c) 2013 KCBODK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTimePickerCell.h"
#import "TMAlertManager.h"
#import "TMAddIntervalViewController.h"

@interface TMViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, TMTimePickerDelegate, TMAlertDelegate,TMAddIntervalDelegate>
@end

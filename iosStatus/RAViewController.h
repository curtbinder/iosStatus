//
//  RAViewController.h
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "RAController.h"

@interface RAViewController : UIViewController

// Buttons
- (IBAction)refresh;

- (void)updateLabelNames;
- (void)updateParameters;
- (BOOL)isHostConfigured;
- (void)displayAlert:(NSString *)title :(NSString *)message;
- (void)setHostValues:(NSString *)host :(NSString *)port :(NSString *)username;
- (void)defaultPrefsChanged:(NSNotification *) notification;


// Text Labels
@property (nonatomic, weak) IBOutlet UILabel *t1Label;
@property (nonatomic, weak) IBOutlet UILabel *t2Label;
@property (nonatomic, weak) IBOutlet UILabel *t3Label;
@property (nonatomic, weak) IBOutlet UILabel *phLabel;
@property (nonatomic, weak) IBOutlet UILabel *dpLabel;
@property (nonatomic, weak) IBOutlet UILabel *apLabel;
@property (nonatomic, weak) IBOutlet UILabel *atolowLabel;
@property (nonatomic, weak) IBOutlet UILabel *atohighLabel;
@property (nonatomic, weak) IBOutlet UILabel *salinityLabel;
@property (nonatomic, weak) IBOutlet UILabel *orpLabel;
@property (nonatomic, weak) IBOutlet UILabel *pheLabel;
@property (nonatomic, weak) IBOutlet UILabel *waterLabel;

// Value Labels
@property (nonatomic, weak) IBOutlet UILabel *updateDate;
@property (nonatomic, weak) IBOutlet UILabel *t1Value;
@property (nonatomic, weak) IBOutlet UILabel *t2Value;
@property (nonatomic, weak) IBOutlet UILabel *t3Value;
@property (nonatomic, weak) IBOutlet UILabel *phValue;
@property (nonatomic, weak) IBOutlet UILabel *dpValue;
@property (nonatomic, weak) IBOutlet UILabel *apValue;
@property (nonatomic, weak) IBOutlet UILabel *atolowValue;
@property (nonatomic, weak) IBOutlet UILabel *atohighValue;
@property (nonatomic, weak) IBOutlet UILabel *salinityValue;
@property (nonatomic, weak) IBOutlet UILabel *orpValue;
@property (nonatomic, weak) IBOutlet UILabel *pheValue;
@property (nonatomic, weak) IBOutlet UILabel *waterValue;

@end

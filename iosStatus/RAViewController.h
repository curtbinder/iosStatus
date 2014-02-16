/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */

#import <UIKit/UIKit.h>
#include "RAController.h"

@interface RAViewController : UIViewController

// Buttons
- (IBAction)refresh;
- (IBAction)toggleButton:(id)sender;
- (IBAction)clearPortOverride:(id)sender;
- (IBAction)modeActivated:(id)sender;

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

// Switches
@property (nonatomic, weak) IBOutlet UISwitch *port1;
@property (nonatomic, weak) IBOutlet UISwitch *port2;
@property (nonatomic, weak) IBOutlet UISwitch *port3;
@property (nonatomic, weak) IBOutlet UISwitch *port4;
@property (nonatomic, weak) IBOutlet UISwitch *port5;
@property (nonatomic, weak) IBOutlet UISwitch *port6;
@property (nonatomic, weak) IBOutlet UISwitch *port7;
@property (nonatomic, weak) IBOutlet UISwitch *port8;

// Port Override Buttons
@property (nonatomic, weak) IBOutlet UIButton *port1Override;
@property (nonatomic, weak) IBOutlet UIButton *port2Override;
@property (nonatomic, weak) IBOutlet UIButton *port3Override;
@property (nonatomic, weak) IBOutlet UIButton *port4Override;
@property (nonatomic, weak) IBOutlet UIButton *port5Override;
@property (nonatomic, weak) IBOutlet UIButton *port6Override;
@property (nonatomic, weak) IBOutlet UIButton *port7Override;
@property (nonatomic, weak) IBOutlet UIButton *port8Override;

// Command Buttons
@property (nonatomic, weak) IBOutlet UISegmentedControl *actionButtons;


@end

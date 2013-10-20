//
//  RAController.h
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RANumber.h"
#import "RARelayBox.h"

@interface RAController : NSObject

@property NSString* updateDate;
@property RANumber* t1;
@property RANumber* t2;
@property RANumber* t3;
@property RANumber* ph;
@property RANumber* phe;
@property BOOL atolow;
@property BOOL atohigh;
@property RANumber* pwmA;
@property RANumber* pwmD;
@property RANumber* water;
@property RANumber* salinity;
@property RANumber* orp;
@property short expansionModules;
@property short relayExpansionModules;
@property RARelayBox* main;

@end

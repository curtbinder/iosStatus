/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */


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

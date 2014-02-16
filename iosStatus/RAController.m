/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */


#import "RAController.h"

@implementation RAController

- (id)init
{
    self = [super init];
    
    if ( self ) {
        _updateDate = @"Never";
        _t1 = [[RANumber alloc] initWithValues:1];
        _t2 = [[RANumber alloc] initWithValues:1];
        _t3 = [[RANumber alloc] initWithValues:1];
        _ph = [[RANumber alloc] initWithValues:2];
        _phe = [[RANumber alloc] initWithValues:2];
        _atolow = FALSE;
        _atohigh = FALSE;;
        _pwmA = [[RANumber alloc] initWithValues:0 :@"%"];
        _pwmD = [[RANumber alloc] initWithValues:0 :@"%"];
        _water = [[RANumber alloc] initWithValues:0 :@"%"];
        _salinity = [[RANumber alloc] initWithValues:1 :@"ppt"];
        _orp = [[RANumber alloc] initWithValues:1 :@"mV"];
        _expansionModules = 0;
        _relayExpansionModules = 0;
        _main = [[RARelayBox alloc] init];
        // add in relays and additional modules
    }
    
    return self;
}

@end

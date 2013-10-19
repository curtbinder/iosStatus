//
//  RAController.m
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

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
        // add in relays and additional modules
    }
    
    return self;
}

@end

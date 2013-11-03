//
//  RARelayBox.m
//  iosStatus
//
//  Created by Curt Binder on 10/20/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import "RARelayBox.h"

const short PORT_OFF = 0;
const short PORT_ON = 1;
const short PORT_STATE_OFF = 0;
const short PORT_STATE_ON = 1;
const short PORT_STATE_AUTO = 2;

@implementation RARelayBox

- (id)init
{
    self = [super init];
    
    if ( self ) {
        _data = 0;
        _maskOff = 0;
        _maskOn = 0;
    }
    
    return self;
}

- (short)getPortStatus:(int)port
{
    short status = PORT_STATE_OFF;
    if ( ([self getPortMaskOnValue:port] == PORT_ON ) &&
        ([self getPortMaskOffValue:port] == PORT_ON) ) {
        status = PORT_STATE_ON;
    } else if ( ([self getPortMaskOnValue:port] == PORT_OFF) &&
               ([self getPortMaskOffValue:port] == PORT_ON) ) {
        status = PORT_STATE_AUTO;
    }
    return status;
}

- (short)getPortMaskOnValue:(int)port
{
    return ((_maskOn & (1 << (port - 1))) >> (port - 1));
}

- (short)getPortMaskOffValue:(int)port
{
    return ((_maskOff & (1 << (port -1))) >> (port -1 ));
}

- (short)getPortValue:(int)port
{
    return (_data & (1 << (port - 1)));
}

- (BOOL)isPortOn:(int)port :(BOOL)useMask
{
    BOOL f = FALSE;
    if ( useMask ) {
        short status = [self getPortStatus:port];
        if ( status == PORT_STATE_ON ) {
            // masked on
            f = TRUE;
        } else if ( status == PORT_STATE_AUTO ) {
            // auto - based on controller settings
            f = ([self getPortValue:port] != PORT_OFF);
        } // else masked off
    } else {
        f = ([self getPortValue:port] != PORT_OFF);
    }
    return f;
}

- (BOOL)isPortOverridden:(int)port
{
    BOOL f = NO;
    short status = [self getPortStatus:port];
    if ( (status == PORT_STATE_ON) || (status == PORT_STATE_OFF) ) {
        f = YES;
    }
    return f;
}

- (BOOL)isOverrideButtonShown:(int)port
{
    // returns the opposite of what the isPortOverridden function returns
    // if the port is overridden, then you will want the button to be visible (aka NOT hidden)
    // if it's not, then you will not want the button to be visible (aka hidden)
    return ![self isPortOverridden:port];
}

@end

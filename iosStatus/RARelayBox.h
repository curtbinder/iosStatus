/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */


#import <Foundation/Foundation.h>

extern const short PORT_OFF;
extern const short PORT_ON;
extern const short PORT_STATE_OFF;
extern const short PORT_STATE_ON;
extern const short PORT_STATE_AUTO;

@interface RARelayBox : NSObject

@property short data;
@property short maskOn;
@property short maskOff;

- (id)init;
- (short)getPortStatus:(int) port;
- (short)getPortMaskOnValue:(int) port;
- (short)getPortMaskOffValue:(int) port;
- (short)getPortValue:(int) port;
- (BOOL)isPortOn:(int) port :(BOOL) useMask;
- (BOOL)isPortOverridden:(int) port;
- (BOOL)isOverrideButtonShown:(int) port;

@end

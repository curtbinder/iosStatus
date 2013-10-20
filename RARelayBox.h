//
//  RARelayBox.h
//  iosStatus
//
//  Created by Curt Binder on 10/20/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const Byte PORT_OFF;
extern const Byte PORT_ON;
extern const Byte PORT_STATE_OFF;
extern const Byte PORT_STATE_ON;
extern const Byte PORT_STATE_AUTO;

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

@end
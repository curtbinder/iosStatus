//
//  RAHost.h
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/19/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAHost : NSObject

- (NSString *) getControllerUrlString;
- (NSURL *) getPortalParamsUrl;
- (NSURL *) getPortalLabelsUrl;

- (BOOL) isHostConfigured;
- (void) setHost:(NSString *)host;
- (void) setPort:(NSString *)port;
- (void) setUsername:(NSString *)username;

- (id)init;
- (id)initWithValues:(NSString *)host :(NSString *)port;

@end

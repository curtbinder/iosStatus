/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */


#import <Foundation/Foundation.h>

@interface RAHost : NSObject

- (NSString *) getControllerUrlString;
- (NSURL *) getPortalParamsUrl;
- (NSURL *) getPortalLabelsUrl;

- (BOOL) isHostConfigured;
- (void) setHost:(NSString *)host;
- (void) setPort:(NSString *)port;
- (void) setRequest:(NSString *)request;
- (void) setUsername:(NSString *)username;
- (void) clearRequest;
- (NSString *) getRequest;

- (id)init;
- (id)initWithValues:(NSString *)host :(NSString *)port;

@end

// Request commands
extern NSString *REQ_MEMORYBYE;
extern NSString *REQ_MEMORYINT;
extern NSString *REQ_STATUS;
extern NSString *REQ_DATETIME;
extern NSString *REQ_VERSION;
extern NSString *REQ_FEEDINGMODE;
extern NSString *REQ_WATERMODE;
extern NSString *REQ_ATOCLEAR;
extern NSString *REQ_OVERHEATCLEAR;
extern NSString *REQ_EXITMODE;
extern NSString *REQ_RELAY;
extern NSString *REQ_LIGHTSON;
extern NSString *REQ_LIGHTSOFF;
extern NSString *REQ_PWMOVERRIDE;
extern NSString *REQ_NONE;
extern NSString *REQ_REEFANGEL;

// Portal URLS
extern NSString *PORTAL_PARAMS_URL;
extern NSString *PORTAL_LABELS_URL;

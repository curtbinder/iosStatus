//
//  RAHost.m
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/19/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import "RAHost.h"

// Request commands
NSString *REQ_MEMORYBYE = @"/mb";
NSString *REQ_MEMORYINT = @"/mi";
NSString *REQ_STATUS = @"/r99";
NSString *REQ_DATETIME = @"/d";
NSString *REQ_VERSION = @"/v";
NSString *REQ_FEEDINGMODE = @"/mf";
NSString *REQ_WATERMODE = @"/mw";
NSString *REQ_ATOCLEAR = @"/mt";
NSString *REQ_OVERHEATCLEAR = @"/mo";
NSString *REQ_EXITMODE = @"/bp";
NSString *REQ_RELAY = @"/r";
NSString *REQ_LIGHTSON = @"/l1";
NSString *REQ_LIGHTSOFF = @"/l0";
NSString *REQ_PWMOVERRIDE = @"/po";
NSString *REQ_NONE = @"";
NSString *REQ_REEFANGEL = @"ra";

// Portal URLS
NSString *PORTAL_PARAMS_URL = @"http://forum.reefangel.com/status/params.aspx?id=";
NSString *PORTAL_LABELS_URL = @"http://forum.reefangel.com/status/labels.aspx?id=";

@implementation RAHost
{
    NSString *_host;
    NSString *_port;
    NSString *_username;
    NSString *_request;
    int _location;
    int _value;
    BOOL _write;
}

- (NSString *) getControllerUrlString;
{
    NSString *address = [NSString stringWithFormat:@"http://%@:%@%@", _host, _port, _request];
    NSString *encodedUrl = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedUrl;
}

- (NSURL *) getPortalParamsUrl
{
    if ( [_username isEqualToString:@""] ) {
        return nil;
    }
    NSString *address = [NSString
                         stringWithFormat:@"%@%@", PORTAL_PARAMS_URL, _username];
    // encode the URL string here since we will be using the URL
    NSString *encodedUrl = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:encodedUrl];
    return url;
}

- (NSURL *) getPortalLabelsUrl
{
    if ( [_username isEqualToString:@""] ) {
        return nil;
    }
    NSString *address = [NSString
                         stringWithFormat:@"%@%@", PORTAL_LABELS_URL, _username];
    // encode the URL string here since we will be using the URL
    NSString *encodedUrl = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:encodedUrl];
    return url;
}

- (BOOL) isHostConfigured
{
    if ( !_host || [_host isEqualToString:@""] ) {
        return FALSE;
    }
    return TRUE;
}

- (NSString *) getRequest
{
    return _request;
}

- (void) setHost:(NSString *)host
{
    _host = host;
}

- (void) setPort:(NSString *)port
{
    _port = port;
}

- (void) setRequest:(NSString *)request
{
    _request = request;
}

- (void) setUsername:(NSString *)username
{
    _username = username;
}

- (void) clearRequest
{
    _request = REQ_NONE;
}

- (id)init
{
    return [self initWithValues:@"" :@"2000"];
}

- (id)initWithValues:(NSString *)host :(NSString *)port
{
    self = [super init];
    
    if ( self ) {
        _host = host;
        _port = port;
        _username = @"";
        _request = @"";
    }
    
    return self;
}

@end

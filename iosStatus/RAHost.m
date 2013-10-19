//
//  RAHost.m
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/19/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import "RAHost.h"

@implementation RAHost
{
    NSString *_host;
    NSString *_port;
    NSString *_username;
}

- (NSString *) getControllerUrlString;
{
    NSString *address = [NSString stringWithFormat:@"http://%@:%@", _host, _port];
    return address;
}

- (NSURL *) getPortalParamsUrl
{
    if ( [_username isEqualToString:@""] ) {
        return nil;
    }
    NSString *address = [NSString
                         stringWithFormat:@"http://forum.reefangel.com/status/params.aspx?id=%@", _username];
    NSURL *url = [[NSURL alloc]initWithString:address];
    return url;
}

- (NSURL *) getPortalLabelsUrl
{
    if ( [_username isEqualToString:@""] ) {
        return nil;
    }
    NSString *address = [NSString
                         stringWithFormat:@"http://forum.reefangel.com/status/labels.aspx?id=%@", _username];
    NSURL *url = [[NSURL alloc]initWithString:address];
    return url;
}

- (BOOL) isHostConfigured
{
    if ( !_host || [_host isEqualToString:@""] ) {
        return FALSE;
    }
    return TRUE;
}

- (void) setHost:(NSString *)host
{
    _host = host;
}

- (void) setPort:(NSString *)port
{
    _port = port;
}

- (void) setUsername:(NSString *)username
{
    _username = username;
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
    }
    
    return self;
}

@end

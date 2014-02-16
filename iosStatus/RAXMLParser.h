/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */

#import <Foundation/Foundation.h>
#import "RAController.h"

@interface RAXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentElementValue;
}

@property (nonatomic, retain) RAController *ra;

- (RAXMLParser *) initXMLParser;

@end

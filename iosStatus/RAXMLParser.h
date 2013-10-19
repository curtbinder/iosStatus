//
//  RAXMLParser.h
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAController.h"

@interface RAXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentElementValue;
}

@property (nonatomic, retain) RAController *ra;

- (RAXMLParser *) initXMLParser;

@end

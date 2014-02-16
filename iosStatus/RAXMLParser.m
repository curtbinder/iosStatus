/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */

#import "RAXMLParser.h"

@implementation RAXMLParser

- (RAXMLParser *) initXMLParser
{
    self = [super init];
    
    if ( self ) {
        currentElementValue = [[NSMutableString alloc] initWithString:@""];
        _ra = [[RAController alloc] init];
    }
    
    return self;
}

- (void) parser:(NSXMLParser *)parser
                didStartElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI
                qualifiedName:(NSString *)qName
                attributes:(NSDictionary *)attributeDict
{
    // parse the start elements
//    if ( [elementName isEqualToString:@"RA"] ) {
//        
//    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // append value to the string
    [currentElementValue appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    // end of xml document, save current date / time from device
    if ( [_ra.updateDate isEqualToString:@"Never"] ) {
        // date is empty, set with current device date/time
        NSLocale *currentLocale = [NSLocale currentLocale];
        NSDateFormatter *dfmt = [[NSDateFormatter alloc] init];
        [dfmt setLocale:currentLocale];
        [dfmt setTimeStyle:NSDateFormatterMediumStyle];
        [dfmt setDateStyle:NSDateFormatterMediumStyle];
        NSDate *now = [NSDate date];
        _ra.updateDate = [dfmt stringFromDate:now];
    }
}

- (void)parser:(NSXMLParser *)parser
                didEndElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI
                qualifiedName:(NSString *)qName
{
//    if ([elementName isEqualToString:@""] ) {
//        // found the end of the element
//        // do something with the currentElementText
//    }
    if ( [elementName isEqualToString:@"RA"] ) {
        return;
    }
    // if status request
    [self processStatusXml:elementName];
    
    [currentElementValue setString:@""];
}

- (void)processStatusXml:(NSString *)tag
{
    if ( [tag isEqualToString:@"T1"] ) {
        [_ra.t1 setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"T2"] ) {
        [_ra.t2 setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"T3"] ) {
        [_ra.t3 setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"PH"] ) {
        [_ra.ph setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"PHE"] ) {
        [_ra.phe setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"ATOLOW"] ) {
        BOOL f = FALSE;
        if ( [currentElementValue intValue] == 1 ) {
            f = TRUE;
        }
        _ra.atolow = f;
    } else if ( [tag isEqualToString:@"ATOHIGH"] ) {
        BOOL f = FALSE;
        if ( [currentElementValue intValue] == 1 ) {
            f = TRUE;
        }
        _ra.atohigh = f;
    } else if ( [tag isEqualToString:@"PWMA"] ) {
        [_ra.pwmA setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"PWMD"] ) {
        [_ra.pwmD setValue:[currentElementValue intValue]];
        
        // ADD IN PWM EXPANSION
    } else if ( [tag isEqualToString:@"SAL"] ) {
        [_ra.salinity setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"ORP"] ) {
        [_ra.orp setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"WL"] ) {
        [_ra.water setValue:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"R"] ) {
        [_ra.main setData:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"RON"] ) {
        [_ra.main setMaskOn:[currentElementValue intValue]];
    } else if ( [tag isEqualToString:@"ROFF"] ) {
        [_ra.main setMaskOff:[currentElementValue intValue]];
        
        // ADD IN LOGDATE here
    } else if ( [tag isEqualToString:@"REM"] ) {
        _ra.relayExpansionModules = [currentElementValue intValue];
    } else if ( [tag isEqualToString:@"EM"] ) {
        _ra.expansionModules = [currentElementValue intValue];
    } else {
        NSLog(@"Unknown Element: %@ (%@)", tag, currentElementValue);
    }
    // ADD IN  AI, VORTECH, RADION, IO, Override, CUSTOM
    // Expansion RON, ROFF, R
}

@end

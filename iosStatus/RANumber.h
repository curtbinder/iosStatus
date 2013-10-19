//
//  RANumber.h
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RANumber : NSObject

- (id)initWithValues:(uint8_t) decimalPlaces :(int) value :(NSString *) suffix;
- (id)initWithValues:(uint8_t) decimalPlaces;
- (id)initWithValues:(uint8_t) decimalPlaces :(NSString *) suffix;
- (id)init;
- (void)setDecimalPlaces:(uint8_t) decimalPlaces;
- (void)setValue:(int) value;
- (void)setValue:(int) value :(uint8_t) decimalPlaces;
- (void)computeNumber;
- (NSString *)toString;

@end

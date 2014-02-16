/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */


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

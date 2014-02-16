/*
 * Copyright (c) 2013 by Curt Binder (http://curtbinder.info)
 *
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/4.0/deed.en_US
 */


#import "RANumber.h"

@implementation RANumber
{
    int _value;
    int _whole;
    int _fraction;
    uint8_t _decimalPlaces;
    NSString *_suffix;
}

- (id)initWithValues:(uint8_t)decimalPlaces :(int)value :(NSString *) suffix
{
    self = [super init];
    
    if ( self ) {
        _decimalPlaces = decimalPlaces;
        _value = value;
        _whole = 0;
        _fraction = 0;
        _suffix = suffix;
    }
    
    return self;
}

- (id)initWithValues:(uint8_t)decimalPlaces :(NSString *)suffix
{
    return [self initWithValues:decimalPlaces :0 :suffix];
}

- (id)initWithValues:(uint8_t)decimalPlaces
{
    return [self initWithValues:decimalPlaces :0 :@""];
}

- (id)init
{
    return [self initWithValues:0 :0 :@""];
}

- (void)setDecimalPlaces:(uint8_t)decimalPlaces
{
    _decimalPlaces = decimalPlaces;
    [self computeNumber];
}

- (void)setValue:(int)value :(uint8_t)decimalPlaces
{
    _value = value;
    _decimalPlaces = decimalPlaces;
    [self computeNumber];
}

- (void)setValue:(int)value
{
    _value = value;
    [self computeNumber];
}

- (void)setSuffix:(NSString*)suffix
{
    _suffix = suffix;
}

- (void)computeNumber
{
    int divisor = 1;
    switch (_decimalPlaces) {
        case 2:
            divisor = 100;
            break;
        case 1:
            divisor = 10;
            break;
        default:
            divisor = 1;
            break;
    }
    _whole = _value / divisor;
    _fraction = _value % divisor;
}

- (NSString *)toString
{
    NSString *s;
    switch (_decimalPlaces) {
        case 2:
            s = [NSString stringWithFormat:@"%d%c%02d", _whole, '.', _fraction];
            break;
        case 1:
            s = [NSString stringWithFormat:@"%d%c%01d", _whole, '.', _fraction];
            break;
        default:
            s = [NSString stringWithFormat:@"%d", _whole];
            break;
    }
    NSString *cat;
    if ( [_suffix isEqualToString:@""] ) {
        cat = s;
    } else {
        cat = [s stringByAppendingString:@" "];
        cat = [cat stringByAppendingString:_suffix];
    }
    return cat;
}

@end

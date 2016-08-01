//
//  NSDate+LAAdditions.m
//  LightAPIClient
//
//  Created by Seth Jordan on 7/10/13.
//  Copyright (c) 2013 SourceGroove. All rights reserved.
//

#import "NSDate+LAAdditions.h"
static NSString* UTC_FORMAT_ISO_8601 = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";
static NSString* UTC_FORMAT_BASIC = @"yyyy-MM-dd'T'HH:mm:ssZ";
static NSString* UTC_FORMAT_FRACTIONAL_SECONDS = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
//last ditch attempts when the Zulu includes :
static NSString* UTC_FORMAT_BASIC_CUSTOMZ = @"yyyy-MM-dd'T'HH:mm:ss-mm:ss";
static NSString* UTC_FORMAT_FRACTIONAL_CUSTOMZ = @"yyyy-MM-dd'T'HH:mm:ss.SSS-mm:ss";

@implementation NSDate(LAAdditions)

-(NSString*)toISO8601{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [format setDateFormat:UTC_FORMAT_ISO_8601];
    return [format stringFromDate:self];
}

+(NSDate*)dateWithObject:(id)object{
    if([object isKindOfClass:[NSString class]]){
        return [NSDate dateWithUTCString:object];
    } else if ([object isKindOfClass:[NSNumber class]]){
        NSNumber *millis = (NSNumber*)object;
        return [self dateWithTimeSinceEpoch:millis];
    }
    
    NSLog(@"I don't know how to parse %@ objects", [object class]);
    return nil;
}

+(NSDate*)dateWithTimeSinceEpochString:(NSString*)milliseconds{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *millis = [f numberFromString:milliseconds];
    
    return [self dateWithTimeSinceEpoch:millis];
}

+(NSDate*)dateWithTimeSinceEpoch:(NSNumber*)milliseconds{
    double millis = [milliseconds doubleValue];
    double seconds = millis / 1000;
    
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

-(NSNumber*)toTimeSince1970{
    NSTimeInterval secondsSinceEpoch = [self timeIntervalSince1970];
    double millisSinceEpoch = secondsSinceEpoch * 1000;
    return [NSNumber numberWithDouble:millisSinceEpoch];
}
/*
 This method is implemented opposite of what you would expect for performance against
 our internal CXF based apis.  The UTC date formats are displaying the Z offset
 with a colon between the hours and minutes.  ie.e '2013-01-16T00:05:00-05:00'
 The last : in the Z isn't represented (as best I can tell) in any NSDateFormatter
 format string.  To combat, I've added my own formats (without using Z) and
 try and parse with those first.  If this library ever opens up to a larger audience
 it would make sense to parse differently.
 */
+(NSDate*)dateWithUTCString:(NSString *)str{
    if(str == nil || str.length == 0){
        return nil;
    }
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:locale];
    [format setDateFormat:UTC_FORMAT_ISO_8601];
    
    NSDate *d = [format dateFromString:str];
    if(d == nil){
        [format setDateFormat:UTC_FORMAT_BASIC_CUSTOMZ];
        d = [format dateFromString:str];
    }
    if(d == nil){
        [format setDateFormat:UTC_FORMAT_FRACTIONAL_SECONDS];
        d = [format dateFromString:str];
    }
    if(d == nil){
        [format setDateFormat:UTC_FORMAT_BASIC];
        d = [format dateFromString:str];
    }
    if(d == nil){
        NSLog(@"Warning: unable to parse string '%@' to date using format %@, %@, %@ or %@",
              str, UTC_FORMAT_ISO_8601,
              UTC_FORMAT_BASIC_CUSTOMZ,
              UTC_FORMAT_FRACTIONAL_SECONDS,
              UTC_FORMAT_BASIC);
    }
    return d;
}
@end

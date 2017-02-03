//
//  NSDate+LAAdditions.m
//  LightAPIClient
//
//  Created by Seth Jordan on 7/10/13.
//  Copyright (c) 2013 SourceGroove. All rights reserved.
//

#import "NSDate+LAAdditions.h"

static NSString *UTC_FORMAT_ISO_8601 = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
static NSString *UTC_FORMAT_ISO_8601_NO_MILLIS = @"yyyy-MM-dd'T'HH:mm:ssZ";
//last ditch attempts when the Zulu includes :
static NSString* UTC_FORMAT_ISO_8601_CUSTOMZ_1 = @"yyyy-MM-dd'T'HH:mm:ss-mm:ss";
static NSString* UTC_FORMAT_ISO_8601_CUSTOMZ_2 = @"yyyy-MM-dd'T'HH:mm:ss.SSS-mm:ss";

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
+(NSDate*)dateWithUTCString:(NSString *)str{
    if(str.length == 0){
        return nil;
    }
    
    NSArray *formats = @[UTC_FORMAT_ISO_8601, UTC_FORMAT_ISO_8601_NO_MILLIS, UTC_FORMAT_ISO_8601_CUSTOMZ_1, UTC_FORMAT_ISO_8601_CUSTOMZ_2];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:locale];
    NSDate *d = nil;
    
    for(NSString *f in formats){
        [format setDateFormat:f];
        d = [format dateFromString:str];
        if(d != nil){
            return d;
        }
    }
    
    NSLog(@"Warning: unable to parse string '%@' to date using format %@, %@, %@, %@ or %@",
          str, UTC_FORMAT_ISO_8601,
          UTC_FORMAT_ISO_8601_NO_MILLIS,
          UTC_FORMAT_ISO_8601_CUSTOMZ_1,
          UTC_FORMAT_ISO_8601_CUSTOMZ_2);
    
    return d;
}
@end

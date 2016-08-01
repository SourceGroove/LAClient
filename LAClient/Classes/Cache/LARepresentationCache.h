//
//  LARepresentationCache.h
//  Huddle
//
//  Created by Seth Jordan on 7/27/16.
//  Copyright © 2016 Booz Allen Hamilton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LARepresentation.h"
#import "LACacheable.h"

@interface LARepresentationCache : NSObject

-(void)clear;
-(void)clearInMemoryOnly;

-(void)setObject:(id)object class:(Class)clazz forKey:(NSString*)key;
-(id)objectWithClass:(Class)clazz key:(NSString*)key list:(BOOL)list;
@end

//
//  LACacheProvider.h
//  Directory
//
//  Created by Seth Jordan on 6/12/14.
//  Copyright (c) 2014 Booz Allen Hamilton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LACacheProvider <NSObject>

-(void)cacheData:(NSData*)data withKey:(NSString*)key lifetime:(NSTimeInterval)lifetime;
-(NSData*)dataWithKey:(NSString*)key;
-(void)clear;

@end

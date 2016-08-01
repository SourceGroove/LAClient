//
//  LAApiError.h
//  Fuse
//
//  Created by Seth Jordan on 3/14/16.
//  Copyright © 2016 531383. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LAJsonRepresentation.h"

@interface LAApiError : LAJsonRepresentation

@property(strong) NSString *title;
@property(nonatomic, retain) NSArray *messages;
@property NSInteger statusCode;

+(id)errorWithTitle:(NSString*)title
           messages:(NSArray*)messages
         statusCode:(NSInteger)statusCode;

@end

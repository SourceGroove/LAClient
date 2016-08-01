//
//  LAJsonLink.h
//  Fuse
//
//  Created by Seth Jordan on 3/14/16.
//  Copyright © 2016 531383. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LAAbstractJsonRepresentation.h"

@interface LAJsonLink : LAAbstractJsonRepresentation
@property (nonatomic, retain) NSString *rel;
@property (nonatomic, retain) NSString *path;
-(NSURL*)url;
-(NSString*)href;
@end

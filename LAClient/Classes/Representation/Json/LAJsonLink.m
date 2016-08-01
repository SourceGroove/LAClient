//
//  LAJsonLink.m
//  Fuse
//
//  Created by Seth Jordan on 3/14/16.
//  Copyright © 2016 531383. All rights reserved.
//

#import "LAJsonLink.h"

@implementation LAJsonLink
-(NSURL*)url{
   return [NSURL URLWithString:self.path];
}
-(NSString*)href{
    return self.path;
}

@end

//
//  LAAbstractJsonRepresentation.h
//  Fuse
//
//  Created by Seth Jordan on 3/14/16.
//  Copyright © 2016 531383. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LARepresentation.h"

@interface LAAbstractJsonRepresentation : NSObject<LARepresentation>

-(NSArray*)typedArrayWithType:(Class)clazz value:(id)value;

-(id)initWithDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)toDictionary;

//Set this if you want custom date formatting during serialization
@property (nonatomic, retain) NSDateFormatter *dateformatter;

@end

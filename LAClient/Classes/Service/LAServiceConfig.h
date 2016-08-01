//
//  LAServiceConfig.h
//  LAClient
//
//  Created by Seth Jordan on 3/14/16.
//  Copyright © 2016 531383. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAServiceConfig : NSObject
@property NSString *apiUri;
@property NSString *oauthUri;
@property NSString *oauthClientId;
@property NSString *oauthClientSecret;
@property NSString *oauthHeaderFormat;
@end

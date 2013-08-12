//
//  TWRestDefines.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWRepoCollection;
@class TWRepoDetails;
@class TWBuildCollection;
@class TWBuildDetails;

@interface TWRestDefines : NSObject

extern NSString * const BASE_URL_STRING;

typedef void (^Success)(void);
typedef void (^SuccessBuildDetails)(TWBuildDetails *buildDetails);
typedef void (^SuccessLog)(NSString *log);
typedef void (^SuccessRepoCollection)(TWRepoCollection *repoCollection);
typedef void (^SuccessRepoDetails)(TWRepoDetails *repoDetails);
typedef void (^SuccessBuildCollection)(TWBuildCollection *buildCollection);
typedef void (^FailureBlock)(NSError *);

@end

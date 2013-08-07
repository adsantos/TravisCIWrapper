//
//  TWRestAPI.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWRestDefines.h"

@interface TWRestAPI : NSObject

+ (void)reposFilteredBy:(NSString *)search onSuccess:(SuccessRepoCollection)success onFailure:(FailureBlock)failure;

@end

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
+ (void)reposFromOwnerName:(NSString *)ownerName onSuccess:(SuccessRepoCollection)success onFailure:(FailureBlock)failure;
+ (void)repoDetailsForRepoId:(NSInteger)repoId onSuccess:(SuccessRepoDetails)success onFailure:(FailureBlock)failure;
+ (void)buildsForRepoName:(NSString *)repoName andOwner:(NSString *)owner onSuccess:(SuccessBuildCollection)success onFailure:(FailureBlock)failure;
+ (void)logsForJobId:(NSInteger)jobId onSuccess:(SuccessLog)success onFailure:(FailureBlock)failure;

@end

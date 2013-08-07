//
//  TWRestAPI.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWRestAPI.h"
#import "TWRestDefines.h"
#import "TWRestHTTPClient.h"
#import "TWParser.h"
#import "TWRepoCollection.h"

// End points
NSString * const GET_REPOS = @"repos";
NSString * const GET_BUILDS = @"builds";
NSString * const GET_JOBS = @"jobs";
NSString * const GET_REPO_DETAILS = @"repos/{repoId}.json";
NSString * const REPO_ID = @"{repoId}";


//Search builds: https://api.travis-ci.org/builds/7928968
//Search jobs: https://api.travis-ci.org/jobs/7928969

// Parameters
NSString * const OWNER_NAME_PARAM = @"owner_name"; //e.g. https://api.travis-ci.org/repos?owner_name=carvil
NSString * const SEARCH_PARAM = @"search";         //e.g. https://api.travis-ci.org/repos?search=carvil

@implementation TWRestAPI

+ (void)reposFilteredWithParams:(NSDictionary *)params onSuccess:(SuccessRepoCollection)success onFailure:(FailureBlock)failure {
    TWRestHTTPClient *client = [TWRestHTTPClient sharedInstance];
    
    [client getPath:GET_REPOS parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            TWRepoCollection *repoCollection = [TWParser parseRepos:response];
            success(repoCollection);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//e.g. https://api.travis-ci.org/repos?search=wrapper
+ (void)reposFilteredBy:(NSString *)search onSuccess:(SuccessRepoCollection)success onFailure:(FailureBlock)failure {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:@[search] forKeys:@[SEARCH_PARAM]];
    [TWRestAPI reposFilteredWithParams:params onSuccess:success onFailure:failure];

}

//e.g. https://api.travis-ci.org/repos?owner_name=carvil
+ (void)reposFromOwnerName:(NSString *)ownerName onSuccess:(SuccessRepoCollection)success onFailure:(FailureBlock)failure {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:@[ownerName] forKeys:@[OWNER_NAME_PARAM]];
    [TWRestAPI reposFilteredWithParams:params onSuccess:success onFailure:failure];
}

//e.g. https://api.travis-ci.org/repos/11433
+ (void)repoDetailsForRepoId:(NSInteger)repoId onSuccess:(SuccessRepoDetails)success onFailure:(FailureBlock)failure {
    TWRestHTTPClient *client = [TWRestHTTPClient sharedInstance];
    
    NSString *path = [GET_REPO_DETAILS stringByReplacingOccurrencesOfString:REPO_ID withString:[NSString stringWithFormat:@"%d", repoId]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            TWRepoDetails *repoCollection = [TWParser parseRepoDetails:response];
            success(repoCollection);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

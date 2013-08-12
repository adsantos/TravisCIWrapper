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
#import "TWBuildCollection.h"
#import "TWBuildDetails.h"

// End points
NSString * const GET_REPOS = @"repos";
NSString * const GET_REPO_DETAILS = @"repos/{repoId}";
NSString * const GET_BUILDS_FOR_REPO = @"repos/{owner}/{repoName}/builds";
NSString * const GET_BUILDS = @"builds";
NSString * const GET_BUILD_DETAILS = @"builds/{buildId}";
NSString * const GET_JOBS = @"jobs";
NSString * const GET_JOBS_FOR_BUILD = @"jobs/{jobId}";

// Replacements
NSString * const REPO_ID = @"{repoId}";
NSString * const REPO_NAME = @"{repoName}";
NSString * const OWNER = @"{owner}";
NSString * const JOB_ID = @"{jobId}";
NSString * const BUILD_ID = @"{buildId}";

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

//e.g. https://api.travis-ci.org/repos/carvil/classify.it/builds
+ (void)buildsForRepoName:(NSString *)repoName andOwner:(NSString *)owner onSuccess:(SuccessBuildCollection)success onFailure:(FailureBlock)failure {
    TWRestHTTPClient *client = [TWRestHTTPClient sharedInstance];
    
    NSString *path = [[GET_BUILDS_FOR_REPO stringByReplacingOccurrencesOfString:REPO_NAME withString:repoName] stringByReplacingOccurrencesOfString:OWNER withString:owner];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            TWBuildCollection *buildCollection = [TWParser parseBuilds:response];
            success(buildCollection);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//e.g. https://api.travis-ci.org/jobs/9051687
+ (void)logsForJobId:(NSInteger)jobId onSuccess:(SuccessLog)success onFailure:(FailureBlock)failure {
    TWRestHTTPClient *client = [TWRestHTTPClient sharedInstance];
    
    NSString *path = [GET_JOBS_FOR_BUILD stringByReplacingOccurrencesOfString:JOB_ID withString:[NSString stringWithFormat:@"%d", jobId]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            NSString *log = [TWParser extractLogFromJobData:response];
            success(log);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//e.g. https://api.travis-ci.org/builds/9051686
+ (void)buildDetailsForBuild:(NSInteger)buildId onSuccess:(SuccessBuildDetails)success onFailure:(FailureBlock)failure {
    TWRestHTTPClient *client = [TWRestHTTPClient sharedInstance];
    
    NSString *path = [GET_BUILD_DETAILS stringByReplacingOccurrencesOfString:BUILD_ID withString:[NSString stringWithFormat:@"%d", buildId]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        if (success) {
            TWBuildDetails *buildDetails = [TWParser parseBuildDetails:response];
            success(buildDetails);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

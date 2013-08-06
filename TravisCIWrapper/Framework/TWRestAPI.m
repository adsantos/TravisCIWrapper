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

// End points
NSString * const GET_REPOS = @"repos";
NSString * const GET_BUILDS = @"builds";
NSString * const GET_JOBS = @"jobs";

//Search builds: https://api.travis-ci.org/builds/7928968
//Search jobs: https://api.travis-ci.org/jobs/7928969

// Parameters
NSString * const OWNER_NAME_PARAM = @"owner_name"; //e.g. https://api.travis-ci.org/repos?owner_name=carvil
NSString * const SEARCH_PARAM = @"search";         //e.g. https://api.travis-ci.org/repos?search=carvil

@implementation TWRestAPI

//e.g.https://api.travis-ci.org/repos?search=wrapper
+ (void)reposFilteredBy:(NSString *)search onSuccess:(Success)success onFailure:(FailureBlock)failure {
    TWRestHTTPClient *client = [TWRestHTTPClient sharedInstance];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:@[search] forKeys:@[SEARCH_PARAM]];
    
    [client getPath:GET_REPOS parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end

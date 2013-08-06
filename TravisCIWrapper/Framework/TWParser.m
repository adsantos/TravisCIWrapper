//
//  TWParser.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWParser.h"
#import "TWRepo.h"
#import "TWRepoCollection.h"

static const NSString *JSON_DESCRIPTION = @"description";
static const NSString *JSON_ID = @"id";
static const NSString *JSON_LAST_BUILD_DURATION = @"last_build_duration";
static const NSString *JSON_LAST_BUILD_FINISHED_AT = @"last_build_finished_at";
static const NSString *JSON_LAST_BUILD_ID = @"last_build_id";
static const NSString *JSON_LAST_BUILD_LANGUAGE = @"last_build_language";
static const NSString *JSON_LAST_BUILD_NUMBER = @"last_build_number";
static const NSString *JSON_LAST_BUILD_RESULT = @"last_build_result";
static const NSString *JSON_LAST_STARTED_AT = @"last_build_started_at";
static const NSString *JSON_LAST_BUILD_STATUS = @"last_build_status";
static const NSString *JSON_SLUG = @"slug";


@implementation TWParser

+ (TWRepo *)parseRepo:(NSDictionary *)reposDictionary {
    
//    NSString *description = [reposDictionary objectForKey:JSON_DESCRIPTION];
    
//    return [[TWRepo alloc] initWithRepoDescription:description repoId:<#(NSInteger)#> lastBuildDuration:<#(NSInteger)#> lastBuildFinishedAt:<#(NSDate *)#> lastBuildId:<#(NSInteger)#> lastBuildLanguage:<#(NSString *)#> lastBuildNumber:<#(NSInteger)#> lastBuildResult:<#(NSInteger)#> lastBuildStartedAt:<#(NSDate *)#> lastBuildStatus:<#(NSInteger)#> slug:<#(NSString *)#>]
    return nil;
}

+ (TWRepoCollection *)parseRepos:(NSData *)reposData {
    if ([reposData length] == 0) {
        return nil;
    }
    
    NSError *parseError;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:reposData options:kNilOptions error:&parseError];
    
    NSMutableArray *repos = [[NSMutableArray alloc] initWithCapacity:[json count]];
    
    for (NSDictionary *repoDictionary in json) {
        TWRepo *repo = [TWParser parseRepo:repoDictionary];
        [repos addObject:repo];
    }
    return [[TWRepoCollection alloc] initWithRepos:repos];
}

@end

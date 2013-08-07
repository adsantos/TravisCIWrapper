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
#import "TWRepoDetails.h"
#import "TWUtils.h"

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
static const NSString *JSON_PUBLIC_KEY = @"public_key";


@implementation TWParser

+ (TWRepo *)parseRepo:(NSDictionary *)reposDictionary {
    
    NSString *description = [reposDictionary objectForKey:JSON_DESCRIPTION];
    int repoId = [[reposDictionary objectForKey:JSON_ID] intValue];
    int lastBuildDuration = [[reposDictionary objectForKey:JSON_LAST_BUILD_DURATION] intValue];
    
    NSDateFormatter *dateFormatter = [TWUtils sharedDateFormatter];
    NSString *lastBuildFinishedAtString = [reposDictionary objectForKey:JSON_LAST_BUILD_FINISHED_AT];
    NSDate *lastBuildFinishedAt = [dateFormatter dateFromString:lastBuildFinishedAtString];
    
    int lastBuildId = [[reposDictionary objectForKey:JSON_LAST_BUILD_ID] intValue];
    NSString *lastBuildLanguage = [reposDictionary objectForKey:JSON_LAST_BUILD_LANGUAGE];
    int lastBuildNumber = [[reposDictionary objectForKey:JSON_LAST_BUILD_NUMBER] intValue];
    int lastBuildResult = [[reposDictionary objectForKey:JSON_LAST_BUILD_RESULT] intValue];
    
    NSString *lastBuildStartedAtString = [reposDictionary objectForKey:JSON_LAST_STARTED_AT];
    NSDate *lastBuildStartedAt = [dateFormatter dateFromString:lastBuildStartedAtString];
    
    int lastBuildStatus = [[reposDictionary objectForKey:JSON_LAST_BUILD_STATUS] intValue];
    
    NSString *slug = [reposDictionary objectForKey:JSON_SLUG];
    
    return [[TWRepo alloc] initWithRepoDescription:description repoId:repoId lastBuildDuration:lastBuildDuration lastBuildFinishedAt:lastBuildFinishedAt lastBuildId:lastBuildId lastBuildLanguage:lastBuildLanguage lastBuildNumber:lastBuildNumber lastBuildResult:lastBuildResult lastBuildStartedAt:lastBuildStartedAt lastBuildStatus:lastBuildStatus slug:slug];
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

+ (TWRepoDetails *)parseRepoDetails:(NSData *)repoDetailsData {
    NSError *parseError;
    NSDictionary *repoDetailsDictionary = [NSJSONSerialization JSONObjectWithData:repoDetailsData options:kNilOptions error:&parseError];
    TWRepo *repo = [TWParser parseRepo:repoDetailsDictionary];
    TWRepoDetails *repoDetails = [[TWRepoDetails alloc] initWithRepo:repo];
    repoDetails.publicKey = [repoDetailsDictionary objectForKey:JSON_PUBLIC_KEY];
    
    return repoDetails;
}

@end

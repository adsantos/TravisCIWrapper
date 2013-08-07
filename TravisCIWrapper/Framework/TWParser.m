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
#import "TWBuild.h"
#import "TWBuildCollection.h"
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

//BUILD
static const NSString *JSON_BRANCH = @"branch";
static const NSString *JSON_COMMIT = @"commit";
static const NSString *JSON_DURATION = @"duration";
static const NSString *JSON_EVENT_TYPE = @"event_type";
static const NSString *JSON_FINISHED_AT = @"finished_at";
static const NSString *JSON_MESSAGE = @"message";
static const NSString *JSON_NUMBER = @"number";
static const NSString *JSON_REPOSITORY_ID = @"repository_id";
static const NSString *JSON_RESULT = @"result";
static const NSString *JSON_STARTED_AT = @"started_at";
static const NSString *JSON_STATE = @"state";



@implementation TWParser

+ (TWRepo *)parseRepo:(NSDictionary *)repoDictionary {
    
    NSString *description = [repoDictionary objectForKey:JSON_DESCRIPTION];
    int repoId = [[repoDictionary objectForKey:JSON_ID] intValue];
    int lastBuildDuration = [[repoDictionary objectForKey:JSON_LAST_BUILD_DURATION] intValue];
    
    NSDateFormatter *dateFormatter = [TWUtils sharedDateFormatter];
    NSString *lastBuildFinishedAtString = [repoDictionary objectForKey:JSON_LAST_BUILD_FINISHED_AT];
    NSDate *lastBuildFinishedAt = [dateFormatter dateFromString:lastBuildFinishedAtString];
    
    int lastBuildId = [[repoDictionary objectForKey:JSON_LAST_BUILD_ID] intValue];
    NSString *lastBuildLanguage = [repoDictionary objectForKey:JSON_LAST_BUILD_LANGUAGE];
    int lastBuildNumber = [[repoDictionary objectForKey:JSON_LAST_BUILD_NUMBER] intValue];
    int lastBuildResult = [[repoDictionary objectForKey:JSON_LAST_BUILD_RESULT] intValue];
    
    NSString *lastBuildStartedAtString = [repoDictionary objectForKey:JSON_LAST_STARTED_AT];
    NSDate *lastBuildStartedAt = [dateFormatter dateFromString:lastBuildStartedAtString];
    
    int lastBuildStatus = [[repoDictionary objectForKey:JSON_LAST_BUILD_STATUS] intValue];
    
    NSString *slug = [repoDictionary objectForKey:JSON_SLUG];
    
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

+ (TWBuild *)parseBuild:(NSDictionary *)buildDictionary {
    NSString *branch = [buildDictionary objectForKey:JSON_BRANCH];
    NSString *commit = [buildDictionary objectForKey:JSON_COMMIT];
    int duration = [[buildDictionary objectForKey:JSON_DURATION] intValue];
    NSString *eventType = [buildDictionary objectForKey:JSON_EVENT_TYPE];
    NSString *finishedAtString = [buildDictionary objectForKey:JSON_FINISHED_AT];
    
    NSDateFormatter *dateFormatter = [TWUtils sharedDateFormatter];
    NSDate *finishedAt = [dateFormatter dateFromString:finishedAtString];
    
    int buildId = [[buildDictionary objectForKey:JSON_ID] intValue];
    NSString *message = [buildDictionary objectForKey:JSON_MESSAGE];
    int buildNumber = [[buildDictionary objectForKey:JSON_NUMBER] intValue];
    int repositoryId = [[buildDictionary objectForKey:JSON_REPOSITORY_ID] intValue];
    int result = [[buildDictionary objectForKey:JSON_RESULT] intValue];
    NSString *startedAtString = [buildDictionary objectForKey:JSON_STARTED_AT];
    NSDate *startedAt = [dateFormatter dateFromString:startedAtString];
    NSString *state = [buildDictionary objectForKey:JSON_STATE];
    
    TWBuild *build = [[TWBuild alloc] initWithBranch:branch commit:commit duration:duration eventType:eventType finishedAt:finishedAt buildId:buildId message:message buildNumber:buildNumber repoId:repositoryId result:result startedAt:startedAt state:state];
    
    return build;
}

+ (TWBuildCollection *)parseBuilds:(NSData *)buildsData {
    if ([buildsData length] == 0) {
        return nil;
    }
    
    NSError *parseError;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:buildsData options:kNilOptions error:&parseError];
    
    NSMutableArray *builds = [[NSMutableArray alloc] initWithCapacity:[json count]];
    
    for (NSDictionary *buildDictionary in json) {
        TWBuild *build = [TWParser parseBuild:buildDictionary];
        [builds addObject:build];
    }
    return [[TWBuildCollection alloc] initWithBuilds:builds];
}

+ (NSString *)extractLogFromJobData:(NSData *)jobData {
    if ([jobData length] == 0) {
        return nil;
    }
    
    NSError *parseError;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jobData options:kNilOptions error:&parseError];
    
    NSString *log = [json objectForKey:@"log"];
    
    return log;
}

@end

//
//  TWRepo.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWRepo.h"

@implementation TWRepo

- (id)initWithRepoDescription:(NSString *)description repoId:(NSInteger)repoId
            lastBuildDuration:(NSInteger)lastBuildDuration lastBuildFinishedAt:(NSDate *)lastBuildFinishedAt
            lastBuildId:(NSInteger)lastBuildId lastBuildLanguage:(NSString *)lastBuildLanguage
            lastBuildNumber:(NSInteger)lastBuildNumber lastBuildResult:(NSInteger)lastBuildResult
            lastBuildStartedAt:(NSDate *)lastBuildStartedAt lastBuildStatus:(NSInteger)lastBuildStatus
            slug:(NSString *)slug {
    
    self = [super init];
    if (self) {
        _repoDescription = description;
        _repoId = repoId;
        _lastBuildDuration = lastBuildDuration;
        _lastBuildFinishedAt = lastBuildFinishedAt;
        _lastBuildId = lastBuildId;
        _lastBuildLanguage = lastBuildLanguage;
        _lastBuildNumber = lastBuildNumber;
        _lastBuildResult = lastBuildResult;
        _lastBuildStartedAt = lastBuildStartedAt;
        _lastBuildStatus = lastBuildStatus;
        _slug = slug;
    }
    return self;
}

@end

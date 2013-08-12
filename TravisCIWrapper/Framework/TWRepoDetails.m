//
//  TWRepoDetails.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWRepoDetails.h"

@implementation TWRepoDetails

- (id)initWithRepoDescription:(NSString *)description repoId:(NSInteger)repoId
            lastBuildDuration:(NSInteger)lastBuildDuration lastBuildFinishedAt:(NSDate *)lastBuildFinishedAt
                  lastBuildId:(NSInteger)lastBuildId lastBuildLanguage:(NSString *)lastBuildLanguage
              lastBuildNumber:(float)lastBuildNumber lastBuildResult:(NSInteger)lastBuildResult
           lastBuildStartedAt:(NSDate *)lastBuildStartedAt lastBuildStatus:(NSInteger)lastBuildStatus
                         slug:(NSString *)slug publicKey:(NSString *)publicKey {
    self = [self initWithRepoDescription:description repoId:repoId lastBuildDuration:lastBuildDuration lastBuildFinishedAt:lastBuildFinishedAt lastBuildId:lastBuildId lastBuildLanguage:lastBuildLanguage lastBuildNumber:lastBuildNumber lastBuildResult:lastBuildResult lastBuildStartedAt:lastBuildStartedAt lastBuildStatus:lastBuildStatus slug:slug];
    if (self) {
        _publicKey = publicKey;
    }
    return self;
}

- (id)initWithRepo:(TWRepo *)repo {
    return [self initWithRepoDescription:repo.repoDescription repoId:repo.repoId lastBuildDuration:repo.lastBuildDuration lastBuildFinishedAt:repo.lastBuildFinishedAt lastBuildId:repo.lastBuildId lastBuildLanguage:repo.lastBuildLanguage lastBuildNumber:repo.lastBuildNumber lastBuildResult:repo.lastBuildResult lastBuildStartedAt:repo.lastBuildStartedAt lastBuildStatus:repo.lastBuildStatus slug:repo.slug];
}

- (NSString *)description {
    NSMutableString *result = [[super description] mutableCopy];
    [result appendFormat:@"\npublicKey: %@", self.publicKey];
    
    return result;
}

@end

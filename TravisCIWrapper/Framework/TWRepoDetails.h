//
//  TWRepoDetails.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWRepo.h"

@interface TWRepoDetails : TWRepo
@property (nonatomic, strong) NSString *publicKey;

- (id)initWithRepoDescription:(NSString *)description repoId:(NSInteger)repoId
            lastBuildDuration:(NSInteger)lastBuildDuration lastBuildFinishedAt:(NSDate *)lastBuildFinishedAt
                  lastBuildId:(NSInteger)lastBuildId lastBuildLanguage:(NSString *)lastBuildLanguage
              lastBuildNumber:(NSInteger)lastBuildNumber lastBuildResult:(NSInteger)lastBuildResult
           lastBuildStartedAt:(NSDate *)lastBuildStartedAt lastBuildStatus:(NSInteger)lastBuildStatus
                         slug:(NSString *)slug publicKey:(NSString *)publicKey;

- (id)initWithRepo:(TWRepo *)repo;

@end

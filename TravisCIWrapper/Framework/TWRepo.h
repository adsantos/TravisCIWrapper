//
//  TWRepo.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRepo : NSObject
@property (nonatomic, strong) NSString *repoDescription;
@property (nonatomic, assign) NSInteger repoId;
@property (nonatomic, assign) NSInteger lastBuildDuration;
@property (nonatomic, strong) NSDate *lastBuildFinishedAt;
@property (nonatomic, assign) NSInteger lastBuildId;
@property (nonatomic, strong) NSString *lastBuildLanguage;
@property (nonatomic, assign) float lastBuildNumber;
@property (nonatomic, assign) NSInteger lastBuildResult;
@property (nonatomic, strong) NSDate *lastBuildStartedAt;
@property (nonatomic, assign) NSInteger lastBuildStatus;
@property (nonatomic, strong) NSString *slug;

- (id)initWithRepoDescription:(NSString *)description repoId:(NSInteger)repoId lastBuildDuration:(NSInteger)lastBuildDuration lastBuildFinishedAt:(NSDate *)lastBuildFinishedAt lastBuildId:(NSInteger)lastBuildId lastBuildLanguage:(NSString *)lastBuildLanguage lastBuildNumber:(float)lastBuildNumber lastBuildResult:(NSInteger)lastBuildResult lastBuildStartedAt:(NSDate *)lastBuildStartedAt lastBuildStatus:(NSInteger)lastBuildStatus slug:(NSString *)slug;

@end

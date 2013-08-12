//
//  TWBuildDetails.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWBuildDetails.h"

@implementation TWBuildDetails

- (id)initWithBuild:(TWBuild *)build {
    return [self initWithBranch:build.branch commit:build.commit duration:build.duration eventType:build.eventType finishedAt:build.finishedAt buildId:build.buildId message:build.message buildNumber:build.buildNumber repoId:build.repoId result:build.result startedAt:build.startedAt state:build.state];
}

- (id)initWithBuild:(TWBuild *)build authorEmail:(NSString *)authorEmail authorName:(NSString *)authorName committedAt:(NSDate *)committedAt committerEmail:(NSString *)committerEmail committerName:(NSString *)committerName compareUrl:(NSURL *)compareUrl config:(TWMatrixConfig *)config matrix:(NSArray *)matrix status:(NSInteger)status {
    self = [self initWithBuild:build];
    if (self) {
        _authorEmail = authorEmail;
        _authorName = authorName;
        _committedAt = committedAt;
        _committerEmail = committerEmail;
        _committerName = committerName;
        _compareUrl = compareUrl;
        _config = config;
        _matrix = matrix;
        _status = status;
    }
    return self;
}

@end

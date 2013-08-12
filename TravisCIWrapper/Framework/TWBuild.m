//
//  TWBuild.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWBuild.h"

@implementation TWBuild

- (id)initWithBranch:(NSString *)branch commit:(NSString *)commit duration:(NSInteger)duration eventType:(NSString *)eventType finishedAt:(NSDate *)finishedAt buildId:(NSInteger)buildId message:(NSString *)message buildNumber:(float)buildNumber repoId:(NSInteger)repoId result:(NSInteger)result startedAt:(NSDate *)startedAt state:(NSString *)state {
    self = [super init];
    if (self) {
        _branch = branch;
        _commit = commit;
        _duration = duration;
        _eventType = eventType;
        _finishedAt = finishedAt;
        _buildId = buildId;
        _message = message;
        _buildNumber = buildNumber;
        _repoId = repoId;
        _result = result;
        _startedAt = startedAt;
        _state = state;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"branch: %@ \ncommit: %@ \nduration: %d \neventType: %@ \nfinishedAt: %@ \nbuildId: %d \nmessage: %@ \nbuildNumber: %f \nrepoId: %d \nresult: %d \nstartedAt: %@ \nstate: %@", self.branch, self.commit, self.duration, self.eventType, self.finishedAt, self.buildId, self.message, self.buildNumber, self.repoId, self.result, self.startedAt, self.state];
}

@end

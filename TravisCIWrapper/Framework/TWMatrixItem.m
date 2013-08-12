//
//  TWMatrixItem.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/8/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWMatrixItem.h"

@implementation TWMatrixItem

- (id)initWithAllowFailure:(BOOL)allowFailure config:(TWMatrixConfig *)config finishedAt:(NSDate *)finishedAt buildId:(int)buildId number:(float)number repoId:(int)repoId result:(int)result startedAt:(NSDate *)startedAt {
    self = [super init];
    if (self) {
        _allowFailure = allowFailure;
        _config = config;
        _finishedAt = finishedAt;
        _buildId = buildId;
        _number = number;
        _repoId = repoId;
        _result = result;
        _startedAt = startedAt;
    }
    return self;
}

@end

//
//  TWRepoCollection.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWRepoCollection.h"

@implementation TWRepoCollection

- (id)initWithRepos:(NSArray *)repos {
    self = [super init];
    if (self) {
        _repos = repos;
    }
    return self;
}

@end

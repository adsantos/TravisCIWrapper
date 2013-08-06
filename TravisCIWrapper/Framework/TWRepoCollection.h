//
//  TWRepoCollection.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRepoCollection : NSObject
@property (nonatomic, strong) NSArray *repos;

- (id)initWithRepos:(NSArray *)repos;

@end

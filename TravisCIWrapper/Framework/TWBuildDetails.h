//
//  TWBuildDetails.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWBuild.h"
#import "TWMatrixConfig.h"

@interface TWBuildDetails : TWBuild
@property (nonatomic, strong) NSString *authorEmail;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSDate *committedAt;
@property (nonatomic, strong) NSString *committerEmail;
@property (nonatomic, strong) NSString *committerName;
@property (nonatomic, strong) NSURL *compareUrl;
@property (nonatomic, strong) TWMatrixConfig *config;
@property (nonatomic, strong) NSArray *matrix; // Array of TWMatrixItem
@property (nonatomic, assign) NSInteger status;

- (id)initWithBuild:(TWBuild *)build;
- (id)initWithBuild:(TWBuild *)build authorEmail:(NSString *)authorEmail authorName:(NSString *)authorName committedAt:(NSDate *)committedAt committerEmail:(NSString *)committerEmail committerName:(NSString *)committerName compareUrl:(NSURL *)compareUrl config:(TWMatrixConfig *)config matrix:(NSArray *)matrix status:(NSInteger)status;

@end

//
//  TWMatrixItem.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/8/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWMatrixConfig.h"

@interface TWMatrixItem : NSObject
@property (nonatomic, assign) BOOL allowFailure;
@property (nonatomic, strong) TWMatrixConfig *config;
@property (nonatomic, strong) NSDate *finishedAt;
@property (nonatomic, assign) int buildId;
@property (nonatomic, assign) float number;
@property (nonatomic, assign) int repoId;
@property (nonatomic, assign) int result;
@property (nonatomic, strong) NSDate *startedAt;

- (id)initWithAllowFailure:(BOOL)allowFailure config:(TWMatrixConfig *)config finishedAt:(NSDate *)finishedAt buildId:(int)buildId number:(float)number repoId:(int)repoId result:(int)result startedAt:(NSDate *)startedAt;

@end

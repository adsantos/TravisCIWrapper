//
//  TWBuild.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWBuild : NSObject
@property (nonatomic, strong) NSString *branch;
@property (nonatomic, strong) NSString *commit;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *eventType;
@property (nonatomic, strong) NSDate *finishedAt;
@property (nonatomic, assign) NSInteger buildId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSInteger buildNumber;
@property (nonatomic, assign) NSInteger repoId;
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSDate *startedAt;
@property (nonatomic, strong) NSString *state;

- (id)initWithBranch:(NSString *)branch commit:(NSString *)commit duration:(NSInteger)duration eventType:(NSString *)eventType finishedAt:(NSDate *)finishedAt buildId:(NSInteger)buildId message:(NSString *)message buildNumber:(NSInteger)buildNumber repoId:(NSInteger)repoId result:(NSInteger)result startedAt:(NSDate *)startedAt state:(NSString *)state;

@end

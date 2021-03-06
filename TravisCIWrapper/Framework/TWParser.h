//
//  TWParser.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWRepoCollection;
@class TWRepoDetails;
@class TWBuildCollection;
@class TWBuildDetails;

@interface TWParser : NSObject

+ (TWRepoCollection *)parseRepos:(NSData *)reposData;
+ (TWRepoDetails *)parseRepoDetails:(NSData *)repoDetailsData;
+ (TWBuildCollection *)parseBuilds:(NSData *)buildsData;
+ (NSString *)extractLogFromJobData:(NSData *)jobData;
+ (TWBuildDetails *)parseBuildDetails:(NSData *)buildDetailsData;

@end

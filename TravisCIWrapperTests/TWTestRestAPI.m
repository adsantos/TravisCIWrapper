//
//  TWTestRestAPI.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "NSURLConnectionVCR.h"
#import "TWRestAPI.h"
#import "TWRepoCollection.h"
#import "TWRepo.h"

@interface TWTestRestAPI : GHAsyncTestCase {}

@end

@implementation TWTestRestAPI

- (void)setUpClass {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *folderName = [NSString stringWithFormat:@"%@/cassette",
                            documentsDirectory];
    
    [NSURLConnectionVCR startVCRWithPath:folderName error:nil];
}

- (void)tearDownClass {
    [NSURLConnectionVCR stopVCRWithError:nil];
}

- (void)testReposFilteredByWord {
    
    __block bool didSucceed = NO;
    __block TWRepoCollection *repoCollection;
    
    NSString *search = @"classify";
    
    [self prepare];
    [TWRestAPI reposFilteredBy:search onSuccess:^(TWRepoCollection *collection) {
        didSucceed = YES;
        repoCollection = collection;
        NSLog(@"%@", [collection description]);
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    // Wait for block to finish or timeout, before doing assertions
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
    GHAssertTrue(didSucceed, @"testGetNetworkReportSummaryNoDatesProvided should succeed");
    GHAssertTrue([repoCollection.repos count] > 0, [NSString stringWithFormat:@"There should be at least 1 repository with the word '%@'.", search]);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"slug=%@", @"carvil/classify.it"];
    NSArray *filteredArray = [repoCollection.repos filteredArrayUsingPredicate:predicate];
    
    GHAssertTrue([filteredArray count] == 1, @"There should be exactly 1 repo where slug = carvil/classify.it");
    TWRepo *repo = [filteredArray lastObject];
    GHAssertTrue([repo.repoDescription isEqualToString:@"Check if a given url points to a tech site"], @"The repo description should not be %@", repo.repoDescription);
    GHAssertTrue(repo.repoId == 11433, @"The repo id should be 11433 instead of %d", repo.repoId);
    GHAssertTrue(repo.lastBuildFinishedAt != nil, @"There should be a date on lastBuildFinishedAt");
    GHAssertTrue(repo.lastBuildStartedAt != nil, @"There should be a date on lastBuildStartedAt");
    GHAssertTrue([repo.slug isEqualToString:@"carvil/classify.it"], @"The slug should be carvil/classify.it");
}


@end

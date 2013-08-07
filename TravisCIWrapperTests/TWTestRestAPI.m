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
#import "TWRepoDetails.h"
#import "TWBuildCollection.h"
#import "TWBuild.h"
#import "TWUtils.h"

#define TIMEOUT 10.0

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
    
//    [NSURLConnectionVCR startVCRWithPath:folderName error:nil];
}

- (void)tearDownClass {
//    [NSURLConnectionVCR stopVCRWithError:nil];
}

- (void)testReposFilteredByWord {
    
    __block bool didSucceed = NO;
    __block TWRepoCollection *repoCollection;
    
    NSString *search = @"classify";
    
    [self prepare];
    [TWRestAPI reposFilteredBy:search onSuccess:^(TWRepoCollection *collection) {
        didSucceed = YES;
        repoCollection = collection;
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    // Wait for block to finish or timeout, before doing assertions
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:TIMEOUT];
    GHAssertTrue(didSucceed, @"testReposFilteredByWord should succeed");
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

- (void)testReposFromOwnerName {
    __block bool didSucceed = NO;
    __block TWRepoCollection *repoCollection;
    
    NSString *ownerName = @"carvil";
    
    [self prepare];
    [TWRestAPI reposFromOwnerName:ownerName onSuccess:^(TWRepoCollection *collection) {
        didSucceed = YES;
        repoCollection = collection;
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    
    // Wait for block to finish or timeout, before doing assertions
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:TIMEOUT];
    GHAssertTrue(didSucceed, @"testReposFromOwnerName should succeed");
    GHAssertTrue([repoCollection.repos count] > 0, [NSString stringWithFormat:@"There should be at least 1 repository with the owner '%@'.", ownerName]);
    
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

- (void)testRepoDetailsForRepoId {
    __block bool didSucceed = NO;
    __block TWRepoDetails *repoDetailsBlock;
    NSInteger repoId = 11433;
    
    [self prepare];
    
    [TWRestAPI repoDetailsForRepoId:repoId onSuccess:^(TWRepoDetails *repoDetails) {
        didSucceed = YES;
        repoDetailsBlock = repoDetails;
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:TIMEOUT];
    GHAssertTrue(didSucceed, @"testRepoDetailsForRepoId should succeed");
    GHAssertTrue([repoDetailsBlock.repoDescription isEqualToString:@"Check if a given url points to a tech site"], @"The repo description should not be %@", repoDetailsBlock.repoDescription);
    GHAssertTrue(repoDetailsBlock.repoId == 11433, @"The repo id should be 11433 instead of %d", repoDetailsBlock.repoId);
    GHAssertTrue(repoDetailsBlock.lastBuildFinishedAt != nil, @"There should be a date on lastBuildFinishedAt");
    GHAssertTrue(repoDetailsBlock.lastBuildStartedAt != nil, @"There should be a date on lastBuildStartedAt");
    GHAssertTrue([repoDetailsBlock.slug isEqualToString:@"carvil/classify.it"], @"The slug should be carvil/classify.it");
    
    NSString *expectedPublicKey = @"-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBAJ4psXXnaQpzEwUMb2wuexKbScEC25w+Ekge4Crv++iBoB0Jv1LkCWR/\nkSVMgmChIjMbC0uuCl17vffPf6Km/Rm/l8V5Nice/DZYokZSaIn4Dg9rQ2uy3ca4\n/x2KE1hBSPhCvjOxZx3xB4+ucLepD4VagtP4U42lPh/IgyWTAIfXAgMBAAE=\n-----END RSA PUBLIC KEY-----\n";
    GHAssertTrue([repoDetailsBlock.publicKey isEqualToString:expectedPublicKey], @"The public key is not the expected.");
}

- (void)testBuildsForRepoNameAndOwner {
    __block bool didSucceed = NO;
    __block TWBuildCollection *buildCollectionBlock;
    
    NSString *repoName = @"classify.it";
    NSString *ownerName = @"carvil";
    
    [self prepare];
    
    [TWRestAPI buildsForRepoName:repoName andOwner:ownerName onSuccess:^(TWBuildCollection *buildCollection) {
        didSucceed = YES;
        buildCollectionBlock = buildCollection;
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:TIMEOUT];
    GHAssertTrue(didSucceed, @"testBuildsForRepoNameAndOwner should succeed");
    GHAssertTrue([buildCollectionBlock.builds count] > 0, @"There should be at least 1 build for the repo '%@' with %@ as owner.", repoName, ownerName);
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"buildId=%d", 1038073];
    NSArray *filteredArray = [buildCollectionBlock.builds filteredArrayUsingPredicate:predicate];
    
    TWBuild *build = [filteredArray lastObject];
    
    GHAssertTrue([filteredArray count] == 1, @"There should be exactly 1 build where id = 1038073");
    GHAssertTrue([build.branch isEqualToString:@"master"], @"The branch should not be %@", build.branch);
    GHAssertTrue([build.commit isEqualToString:@"9075857fc762001c5b3f672167b697307661d810"], @"The commit should not be %@", build.commit);
    GHAssertTrue(build.duration == 77, @"The duration should not be %d", build.duration);
    GHAssertTrue([build.eventType isEqualToString:@"push"], @"The event type should not be %@", build.eventType);
    
    NSDateFormatter *dateFormatter = [TWUtils sharedDateFormatter];
    NSString *finishedAtExpectedString = @"2012-04-07T10:24:25Z";
    NSDate *finishedAtExpected = [dateFormatter dateFromString:finishedAtExpectedString];
    GHAssertTrue([build.finishedAt isEqualToDate:finishedAtExpected], @"The finished at date should be %@ instead of %@", finishedAtExpected, build.finishedAt);
    
    NSInteger buildIdExpected = 1038073;
    GHAssertTrue(build.buildId == buildIdExpected, @"The build id should be %d instead of %d", buildIdExpected, build.buildId);
    
    GHAssertTrue([build.message isEqualToString:@"add link to blog post"], @"The message should not be %@", build.message);
    GHAssertTrue(build.buildNumber == 7, @"The build number should not be %d", build.buildNumber);
    GHAssertTrue(build.repoId == 11433, @"The repo id should not be %d", build.repoId);
    GHAssertTrue(build.result == 0, @"The build result should not be %d", build.result);
    
    NSString *startedAtExpectedString = @"2012-04-07T10:23:37Z";
    NSDate *startedAtExpected = [dateFormatter dateFromString:startedAtExpectedString];
    GHAssertTrue([build.startedAt isEqualToDate:startedAtExpected], @"The started date should be %@ instead of %@", startedAtExpected, build.startedAt);
    
    GHAssertTrue([build.state isEqualToString:@"finished"], @"The build state should not be %@", build.state);
}

- (void)testLogsForJobId {
    __block bool didSucceed = NO;
    __block NSString *logBlock;
    
    [self prepare];
    
    [TWRestAPI logsForJobId:9051687 onSuccess:^(NSString *logString) {
        didSucceed = YES;
        logBlock = logString;
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:TIMEOUT];
    GHAssertTrue(didSucceed, @"testLogsForJobId should succeed");
    GHAssertTrue([logBlock length] == 22001, @"The log should have a length of 22001");
}

@end

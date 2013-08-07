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
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } onFailure:^(NSError *error) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    }];
    // Wait for block to finish or timeout, before doing assertions
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:TIMEOUT];
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
    GHAssertTrue(didSucceed, @"testGetNetworkReportSummaryNoDatesProvided should succeed");
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
        didSucceed = NO;
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

@end

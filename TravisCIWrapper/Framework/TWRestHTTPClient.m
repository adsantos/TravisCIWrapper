//
//  TWRestHTTPClient.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWRestHTTPClient.h"
#import "TWRestDefines.h"

@implementation TWRestHTTPClient

+ (TWRestHTTPClient *)sharedInstance {
    static TWRestHTTPClient *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_STRING]];
        [sharedInstance setDefaultHeader:@"content-type" value:@"application/json"];
    });
    
    return sharedInstance;
}

@end

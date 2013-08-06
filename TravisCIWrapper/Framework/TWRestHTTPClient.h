//
//  TWRestHTTPClient.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/6/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "AFHTTPClient.h"

@interface TWRestHTTPClient : AFHTTPClient

+ (TWRestHTTPClient *)sharedInstance;

@end

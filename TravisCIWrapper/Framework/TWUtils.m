//
//  TWUtils.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWUtils.h"

@implementation TWUtils

+(NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUKLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK_POSIX"];
        [dateFormatter setLocale:enUKLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"]; //2013-07-13T23:02:42Z
    });
    return dateFormatter;
}

@end

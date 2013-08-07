//
//  TWBuildCollection.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWBuildCollection.h"
#import "TWBuild.h"

@implementation TWBuildCollection

- (id)initWithBuilds:(NSArray *)builds {
    self = [super init];
    if (self) {
        _builds = builds;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (TWBuild *build in self.builds) {
        [result appendFormat:@"%@\n----------------------------\n", [build description]];
    }
    
    return result;
}

@end

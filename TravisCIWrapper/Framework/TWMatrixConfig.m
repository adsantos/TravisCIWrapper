//
//  TWMatrixConfig.m
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/8/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import "TWMatrixConfig.h"

@implementation TWMatrixConfig

- (id)initWithResult:(NSString *)result jdk:(NSArray *)jdk language:(NSString *)language lein:(NSString *)lein script:(NSString *)script {
    self = [super init];
    if (self) {
        _result = result;
        _jdk = jdk;
        _language = language;
        _lein = lein;
        _script = script;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"result: %@, jdk: %@, language: %@, lein: %@, script: %@", self.result, self.jdk, self.language, self.lein, self.script];
}

@end

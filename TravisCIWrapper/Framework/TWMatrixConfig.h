//
//  TWMatrixConfig.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/8/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWMatrixConfig : NSObject
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSArray *jdk;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *lein;
@property (nonatomic, strong) NSString *script;

- (id)initWithResult:(NSString *)result jdk:(NSArray *)jdk language:(NSString *)language lein:(NSString *)lein script:(NSString *)script;

@end

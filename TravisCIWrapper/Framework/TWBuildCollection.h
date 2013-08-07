//
//  TWBuildCollection.h
//  TravisCIWrapper
//
//  Created by Y.CORP.YAHOO.COM\asantos on 8/7/13.
//  Copyright (c) 2013 asantos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWBuildCollection : NSObject
@property (nonatomic, strong) NSArray *builds;

- (id)initWithBuilds:(NSArray *)builds;

@end

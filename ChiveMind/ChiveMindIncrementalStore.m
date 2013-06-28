//
//  ChiveMindIncrementalStore.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "ChiveMindIncrementalStore.h"
#import "GLImgurClient.h"
@implementation ChiveMindIncrementalStore
+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ChiveMind" withExtension:@"xcdatamodeld"]];
}

- (id<AFIncrementalStoreHTTPClient>)HTTPClient {
    return [GLImgurClient sharedClient];
}
@end

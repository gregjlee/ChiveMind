//
//  GLImgurClient.h
//  ImgurTest
//
//  Created by Gregory Lee on 6/27/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFRESTClient.h"
#import "AFIncrementalStore.h"
extern NSString * const kImgurBaseURLString;
extern NSString * const kClientId;
extern NSString * const kRedirectUrl;

// Endpoints
extern NSString * const kAlbumEndpoint;

extern NSString * const kLocationsEndpoint;
extern NSString * const kLocationsMediaRecentEndpoint;
extern NSString * const kUserMediaRecentEndpoint;
extern NSString * const kAuthenticationEndpoint;

@interface GLImgurClient : AFRESTClient <AFIncrementalStoreHTTPClient>
+ (GLImgurClient *)sharedClient;
- (id)initWithBaseURL:(NSURL *)url;
+ (void)getAlbumWithId:(NSString*)albumID
                 block:(void (^)(NSArray *records))block;
+ (void)getEndPoint:(NSString *)endPoint;
@end

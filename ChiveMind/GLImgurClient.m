//
//  GLImgurClient.m
//  ImgurTest
//
//  Created by Gregory Lee on 6/27/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "GLImgurClient.h"
#import "TTTDateTransformers.h"

#import "AFJSONRequestOperation.h"
NSString * const kImgurBaseURLString = @"https://api.imgur.com/3/";
#warning Include your client id from instagr.am
NSString * const kClientId = @"fcf69e034c48027";

#warning Include your redirect uri
NSString * const kRedirectUrl = @"instagram://authorize";


// Endpoints
NSString * const kAlbumEndpoint = @"gallery/album/lUu2ECm";
NSString * const kLocationsEndpoint = @"locations/search";
NSString * const kLocationsMediaRecentEndpoint = @"locations/%@/media/recent";
NSString * const kUserMediaRecentEndpoint = @"users/%@/media/recent";
NSString * const kAuthenticationEndpoint =
@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token";

@implementation GLImgurClient
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Client-ID %@", kClientId]];
    
    return self;
}

+ (GLImgurClient *)sharedClient
{
    static GLImgurClient * _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kImgurBaseURLString]];
    });
    
    return _sharedClient;
}

#pragma mark - AFIncrementalStore

- (NSURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                             withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *mutableURLRequest = nil;
    if ([fetchRequest.entityName isEqualToString:@"LineImage"]) {
        mutableURLRequest = [self requestWithMethod:@"GET" path:@"gallery/hot/viral/0" parameters:nil];
        
    }
    
    return mutableURLRequest;
}

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    return [responseObject valueForKey:@"data"];
}

- (id)representationOrArrayOfRepresentationsOfEntity:(NSEntityDescription *)entity
                                  fromResponseObject:(id)responseObject
{
    id ro = [super representationOrArrayOfRepresentationsOfEntity:entity fromResponseObject:responseObject];
    
    if ([ro isKindOfClass:[NSDictionary class]]) {
        id value = nil;
        value = [ro valueForKey:@"data"];
        if (value) {
            return value;
        }
    }
    
    return ro;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    if ([entity.name isEqualToString:@"LineImage"]) {
        [mutablePropertyValues setValue:[representation valueForKey:@"id"] forKey:@"lineID"];
        [mutablePropertyValues setValue:[representation valueForKey:@"title"] forKey:@"title"];
        [mutablePropertyValues setValue:[representation valueForKey:@"link"] forKey:@"imageURL"];
        
        [mutablePropertyValues setValue:[NSNumber numberWithBool:[[representation valueForKey:@"is_album"] boolValue]] forKey:@"isAlbum"];
        [mutablePropertyValues setValue:[NSNumber numberWithInteger:[[representation valueForKey:@"score"] integerValue]] forKey:@"score"];
        [mutablePropertyValues setValue:[representation valueForKey:@"section"] forKey:@"section"];
    }
//    else if ([entity.name isEqualToString:@"User"]) {
//        [mutablePropertyValues setValue:[NSNumber numberWithInteger:[[representation valueForKey:@"id"] integerValue]] forKey:@"userID"];
//        [mutablePropertyValues setValue:[representation valueForKey:@"username"] forKey:@"username"];
//        [mutablePropertyValues setValue:[representation valueForKeyPath:@"avatar_image.url"] forKey:@"avatarImageURLString"];
//    }
    
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}
#pragma mark album
+ (void)getAlbumWithId:(NSString*)albumID
                 block:(void (^)(NSArray *records))block{
    NSString *AlbumEndpoint = [NSString stringWithFormat:@"album/%@/images",albumID];
    [[self sharedClient] getPath:AlbumEndpoint
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      NSArray* data = [responseObject objectForKey:@"data"];
                                      if (data) {
                                          
                                      }
                                      else{
                                          NSLog(@"null data");
                                      }
                                      if (block) {
                                          block(data);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error: %@", error.localizedDescription);
                                      if (block) {
                                          block([NSArray array]);
                                      }
                                  }];
    
}

@end

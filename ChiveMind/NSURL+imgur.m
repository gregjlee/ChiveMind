//
//  NSURL+imgur.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "NSURL+imgur.h"
#import "LineImage.h"
#import "GLImgurClient.h"
@implementation NSURL (imgur)
+(NSURL*)urlWithImageData:(NSDictionary *)imageData size:(NSString *)size{
    if (!size) {
        size=@"";
    }
    NSArray* split = [imageData[@"type"] componentsSeparatedByString: @"/"];
    NSString *type = [split lastObject];
    NSString *link=[NSString stringWithFormat:@"http://i.imgur.com/%@%@.%@",imageData[@"id"],size, type];
    return [self URLWithString:link];
}
+(NSURL*)urlFromLineImage:(LineImage*)lineImage size:(NSString *)size{
    if ([lineImage.isAlbum boolValue]) {
        
        return nil;
    }
    else{
        NSArray* split = [lineImage.imageURL componentsSeparatedByString: @"."];
        NSString *type = [split lastObject];
        NSString *link=[NSString stringWithFormat:@"http://i.imgur.com/%@%@.%@",lineImage.lineID,size, type];
        return [self URLWithString:link];

    }
}
/*
s,
b, t ,b, m, h
 */
//gallery/image/nFlnmH1
/* lineimage Album Json
 "account_url" = SellYourKids;
 cover = nFlnmH1;
 datetime = 1372359992;
 description = "<null>";
 downs = 45;
 favorite = 0;
 id = g0k5l;
 "is_album" = 1;
 layout = blog;
 link = "http://imgur.com/a/g0k5l";
 nsfw = 0;
 privacy = public;
 score = 6371;
 section = funny;
 title = "These two will always be my favorite movie parents";
 ups = 6416;
 views = 199933;
 vote = "<null>";
 */
@end

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
    NSArray* split = [imageData[@"link"] componentsSeparatedByString: @"."];
    NSString *type = [split lastObject];
    NSString *link=[NSString stringWithFormat:@"http://i.imgur.com/%@%@.%@",imageData[@"id"],size, type];
    NSLog(@"imageDataURL %@",link);
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
 
 
 image json
 animated = 1;
 bandwidth = 80078322976;
 datetime = 1372422503;
 description = "<null>";
 favorite = 0;
 height = 210;
 id = tUFpXpI;
 link = "http://i.imgur.com/tUFpXpI.gif";
 nsfw = "<null>";
 section = "<null>";
 size = 1704592;
 title = "<null>";
 type = "image/gif";
 views = 46978;
 width = 245;
 
 
 gallery/hot/viral
 "account_url" = amandil;
 cover = OojBAqT;
 datetime = 1372601215;
 description = "<null>";
 downs = 28;
 favorite = 0;
 id = 0VOrz;
 "is_album" = 1;
 layout = blog;
 link = "http://imgur.com/a/0VOrz";
 nsfw = 0;
 privacy = public;
 score = 3569;
 section = "<null>";
 title = "I think Vladamir Kush deserves imgurian recognition";
 ups = 3597;
 views = 1650;
 vote = "<null>";

 */
@end

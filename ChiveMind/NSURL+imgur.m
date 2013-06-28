//
//  NSURL+imgur.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "NSURL+imgur.h"

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
/*
s,
b, t ,b, m, h
 */
@end

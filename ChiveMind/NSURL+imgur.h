//
//  NSURL+imgur.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (imgur)
+(NSURL*)urlWithImageData:(NSDictionary *)imageData size:(NSString *)size;
@end

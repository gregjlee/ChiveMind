//
//  AlbumViewCell.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "AlbumViewCell.h"
#import "AFNetworking.h"
@implementation AlbumViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)configureCellWithImageURL:(NSURL *)imageURL{
    
if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    [_imageView setImageWithURL:imageURL];
    
}
/*
animated = 1;
bandwidth = 0;
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
views = 0;
width = 245;
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

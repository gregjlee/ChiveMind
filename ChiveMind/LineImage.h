//
//  LineImage.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LineImage : NSManagedObject

@property (nonatomic, retain) NSString * lineID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * isAlbum;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * section;

//"account_url" = "<null>";
//animated = 0;
//bandwidth = 21973017000;
//datetime = 1372309008;
//description = "<null>";
//downs = 38;
//favorite = 0;
//height = 610;
//id = 7cJSswN;
//"is_album" = 0;
//link = "http://i.imgur.com/7cJSswN.png";
//nsfw = 0;
//score = 3043;
//section = AdviceAnimals;
//size = 170004;
//title = "I'm lucky my wife ever married me.";
//type = "image/png";
//ups = 2708;
//views = 129250;
//vote = "<null>";
//width = 610;
@end

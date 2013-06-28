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

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * isAlbum;
@property (nonatomic, retain) NSString * lineID;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * coverID;
@property (nonatomic, retain) NSNumber * count;

@end

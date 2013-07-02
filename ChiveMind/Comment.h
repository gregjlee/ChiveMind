//
//  Comment.h
//  ChiveMind
//
//  Created by Gregory Lee on 7/1/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comment : NSManagedObject
@property (nonatomic, retain) NSString * imageID;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) NSNumber * datetime;

@end

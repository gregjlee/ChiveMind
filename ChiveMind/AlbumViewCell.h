//
//  AlbumViewCell.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "PSTCollectionViewCell.h"
#import "PSTCollectionView.h"
@interface AlbumViewCell : PSUICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
-(void)configureCellWithImageURL:(NSURL *)imageURL;
@end

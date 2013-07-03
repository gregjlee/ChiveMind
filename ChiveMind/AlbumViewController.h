//
//  AlbumViewController.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"
#import "LineImage.h"
#import "MWPhotoBrowser.h"
@interface AlbumViewController : UIViewController <PSTCollectionViewDelegateFlowLayout,PSTCollectionViewDataSource, MWPhotoBrowserDelegate>
@property (nonatomic,strong)PSTCollectionView *collectionView;
@property (nonatomic,strong)LineImage *lineImage;
@property (nonatomic,strong)NSArray *imagesData;
-(void)refreshData;
@end

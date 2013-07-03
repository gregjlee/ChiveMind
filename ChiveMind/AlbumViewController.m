//
//  AlbumViewController.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumViewCell.h"
#import "GLImgurClient.h"
#import "NSURL+imgur.h"
#import "ImageViewController.h"

#define CellIdentifier @"cell"
@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImages];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)loadImages{
    [GLImgurClient getAlbumImagesWithId:_lineImage.lineID block:^(NSArray *records) {
        _imagesData=records;
        NSLog(@"image data %@",_imagesData);
        [self configureCollectionView];
        
    }];
}
-(void)configureCollectionView{
    if (!_collectionView) {
        PSUICollectionViewFlowLayout *flowLayout= [[PSUICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:PSTCollectionViewScrollDirectionVertical];
        _collectionView=[[PSUICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerClass:[AlbumViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_collectionView];
    }
}

#pragma mark Collection View Data Source

- (NSString *)formatIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
    NSDictionary *imageData=_imagesData[indexPath.row];
    [cell configureCellWithImageURL:[NSURL urlWithImageData:imageData size:@"t"]];

    return cell;
}

- (CGSize)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70, 70);
}

- (NSInteger)collectionView:(PSUICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _imagesData.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView{
    return 1;
}

#pragma mark – UICollectionViewDelegateFlowLayout


// 3
- (UIEdgeInsets)collectionView:
(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 2, 5, 2);
}

-(void)collectionView:(PSUICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    [browser setInitialPageIndex:indexPath.row];
    [self.navigationController pushViewController:browser animated:YES];

}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _imagesData.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _imagesData.count)
        return [MWPhoto photoWithURL:[NSURL urlWithImageData:_imagesData[index] size:nil]];
    return nil;
    
}
//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

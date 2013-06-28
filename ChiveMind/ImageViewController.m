//
//  ImageViewController.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "ImageViewController.h"
#import "AFNetworking.h"
#import "NSURL+imgur.h"
@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectedIndex=0;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureScrollView];
    // Do any additional setup after loading the view from its nib.
}
-(void)configureScrollView{
    CGSize viewSize=self.scrollView.bounds.size;
    _scrollView.contentSize=CGSizeMake(viewSize.width*_imagesData.count, viewSize.height);
    for (int i=0; i<_imagesData.count; i++) {
        CGRect imagFrame=CGRectOffset(self.scrollView.bounds, i*viewSize.width, 0);
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:imagFrame];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImageWithURL:[NSURL urlWithImageData:_imagesData[i] size:@"m"]];
        [_scrollView addSubview:imageView];
    }
    [self scrollToIndex:_selectedIndex animated:NO];
}
-(void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    NSLog(@"scroll to index %d",index);
    CGSize viewSize=self.scrollView.bounds.size;
    CGRect scrollFrame=CGRectMake(index*viewSize.width, 0, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:scrollFrame animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end

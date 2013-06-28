//
//  ImageViewController.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *imagesData;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

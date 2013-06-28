//
//  DetailViewController.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineImage.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) LineImage *lineImage;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

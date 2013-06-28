//
//  DetailViewController.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setLineImage:(LineImage *)newLineImage
{
    if (_lineImage != newLineImage) {
        _lineImage = newLineImage;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.lineImage) {
        self.detailDescriptionLabel.text = self.lineImage.title;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
        NSURL *imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@m.jpg",self.lineImage.lineID]];
        [imageView setImageWithURL:imageURL];
        [self.view addSubview:imageView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
@end

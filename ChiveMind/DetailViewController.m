//
//  DetailViewController.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "NSURL+imgur.h"
#import "GLImgurClient.h"
#import "Comment.h"
#import "CommentViewCell.h"
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
        self.navigationItem.title=self.lineImage.title;
        self.detailDescriptionLabel.text = self.lineImage.title;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
        UIImage *placeHolder=[UIImage imageNamed:@"placeHolder.gif"];
        NSURL *imageURL=[NSURL urlWithLineImage:self.lineImage size:nil];
        [imageView setImageWithURL:imageURL placeholderImage:placeHolder];
        [self.view addSubview:imageView];
//        [GLImgurClient getCommentsForLineImage:self.lineImage block:^(NSArray *records) {
//            NSLog(@"comments %@",records);
//        }];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    CGRect tableFrame=CGRectInset(self.view.bounds, 10, 50);
    self.tableView=[[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.hidden=YES;
    
    [self refetchData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Comment"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO]];
    NSString *attributeName = @"imageID";
    NSString *attributeValue = self.lineImage.lineID;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@",
                              attributeName, attributeValue];
    fetchRequest.predicate=predicate;
    
    fetchRequest.fetchLimit = 20;
    fetchRequest.fetchBatchSize = 10;
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:@"GlobalStream"];
    _fetchedResultsController.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [GLImgurClient getCommentsForLineImage:self.lineImage block:^(NSArray *records) {
        NSLog(@"comments %@",records);
    }];
}

-(void)handleTapGesture:(UITapGestureRecognizer *)tapGesture{
    self.tableView.hidden=!self.tableView.hidden;
}
#pragma mark - Table View
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CommentViewCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CommentViewCell class]])
            {
                cell = (CommentViewCell *)currentObject;
                break;
            }
        }
    }
    [self configureCell:cell forIndexPath:indexPath];

    return cell;
}
-(void)configureCell:(CommentViewCell *)cell forIndexPath:(NSIndexPath*)indexPath{
    Comment *comment = (Comment*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.commentLabel.text=comment.text;
    cell.authorLabel.text=comment.author;
    cell.pointsLabel.text=[NSString stringWithFormat:@"%d pts",[comment.points integerValue]];

}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)refetchData {
    [_fetchedResultsController performSelectorOnMainThread:@selector(performFetch:) withObject:nil waitUntilDone:YES modes:@[ NSRunLoopCommonModes ]];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
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

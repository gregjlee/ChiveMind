//
//  MasterViewController.m
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//
#import "AFNetworking.h"
#import "MasterViewController.h"
#import "LineImage.h"
#import "DetailViewController.h"
#import "AlbumViewController.h"
#import "GLImgurClient.h"
#import "GalleryViewCell.h"
#import "NSURL+imgur.h"
#import "SVPullToRefresh.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"ChiveMind";
    }
    return self;
}
- (void)refetchData {
    [_fetchedResultsController performSelectorOnMainThread:@selector(performFetch:) withObject:nil waitUntilDone:YES modes:@[ NSRunLoopCommonModes ]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LineImage"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lineID" ascending:NO]];
    fetchRequest.fetchLimit = 20;
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:@"GlobalStream"];
    _fetchedResultsController.delegate = self;
    
    __weak MasterViewController *weakSelf=self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refetchData];
    }];
    [self.tableView triggerPullToRefresh];
    
    
    // setup infinite scrolling
//    [GLImgurClient getEndPoint:@"gallery/album/xm3jI"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    GalleryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GalleryViewCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[GalleryViewCell class]])
            {
                cell = (GalleryViewCell *)currentObject;
                break;
            }
        }
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(GalleryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    LineImage *lineImage = (LineImage*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleLabel.text = lineImage.title;
    cell.detailLabel.text=lineImage.section;
    cell.scoreLabel.text=[NSString stringWithFormat:@"%d pts", [lineImage.score integerValue]];
    UIImage *placeHolderImage=[UIImage imageNamed:@"placeHolder.gif"];
    cell.countLabel.hidden=YES;
    if ([lineImage.isAlbum boolValue]) {
        cell.imageView.image=placeHolderImage;
        [GLImgurClient getAlbumCoverWithLineImage:lineImage block:^(NSArray *records) {
            cell.countLabel.hidden=NO;
            NSDictionary *albumData=(NSDictionary *)records;
            cell.countLabel.text=[NSString stringWithFormat:@"%@ picts",albumData[@"images_count"]];
            NSArray *images = albumData[@"images"];
            [cell.imageView setImageWithURL: [NSURL urlWithImageData:images[0] size:@"s"] placeholderImage:placeHolderImage];
        }];
    }
    else{
        [cell.imageView setImageWithURL: [NSURL urlWithLineImage:lineImage size:@"s"] placeholderImage:placeHolderImage];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LineImage *lineImage = (LineImage*)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    if ([lineImage.isAlbum boolValue]) {
        AlbumViewController *albumVC = [[AlbumViewController alloc]initWithNibName:@"AlbumViewController" bundle:nil];
        albumVC.lineImage=lineImage;
        
        [self.navigationController pushViewController:albumVC animated:YES];
        
    }
    else{
        if (!self.detailViewController) {
            self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        }
        [[GLImgurClient sharedClient]setSelectedID:lineImage.lineID];
        self.detailViewController.lineImage = lineImage;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
    
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
    __weak MasterViewController *weakSelf=self;
    [weakSelf.tableView.pullToRefreshView stopAnimating];

}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
   
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


@end

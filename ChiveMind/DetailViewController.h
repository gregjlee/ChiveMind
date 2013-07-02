//
//  DetailViewController.h
//  ChiveMind
//
//  Created by Gregory Lee on 6/28/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "LineImage.h"
@interface DetailViewController : UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong, nonatomic) LineImage *lineImage;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)UITableView *tableView;
@end

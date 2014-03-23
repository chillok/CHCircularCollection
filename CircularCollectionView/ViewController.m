//
//  ViewController.m
//  RotatingCollectionView
//
//  Created by Cillian on 22/03/2014.
//  Copyright (c) 2014 Cillian. All rights reserved.
//

#import "ViewController.h"
#import "CHCircularCollectionLayout.h"

static NSString *kCollectionViewCell = @"CollectionViewCellIdentifier";

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController {

    NSArray *items;
}
- (void)setup
{
    NSInteger numItems = 50;
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < numItems; i++) {
        [array addObject:@"item"];
    }
    items = [[NSArray alloc] initWithArray:array];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    CHCircularCollectionLayout *layout = [CHCircularCollectionLayout new];
    layout.cellStyle = CellStyleRotateToCenter;

    [_collectionView setCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 10, 10)];
    [label setText:[NSString stringWithFormat:@"%d", indexPath.row]];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:6]];
    [cell addSubview:label];
    return cell;
}



@end

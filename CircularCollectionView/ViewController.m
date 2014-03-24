//
//  ViewController.m
//  RotatingCollectionView
//
//  Created by Cillian on 22/03/2014.
//  Copyright (c) 2014 Cillian. All rights reserved.
//

#import "ViewController.h"
#import "CHCircularCollectionLayout.h"
#import "UIColor+Custom.h"
#import "UIView+Custom.h"

static NSString *kCollectionViewCell = @"CollectionViewCellIdentifier";

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController {

    NSArray *items;
    NSMutableArray *colors;
}

- (void)setup
{
    colors = [NSMutableArray new];
    
    NSInteger numItemsPerSection = 6;
    NSInteger numSections = 3;
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSInteger sectionCount = 0; sectionCount < numSections; sectionCount++) {
        NSMutableArray *section = [NSMutableArray new];
        
        [colors addObject:[UIColor randomColor]];
        
        for (NSInteger itemCount = 0; itemCount < numItemsPerSection; itemCount++) {
            [section addObject:@"item"];
        }
        
        [array addObject:section];
    }
    
    items = [[NSArray alloc] initWithArray:array];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    CHCircularCollectionLayout *layout = [CHCircularCollectionLayout new];
    layout.cellStyle = CellStyleRotateToCenter;
    layout.sectionStyle = SectionStyleSingleRing;

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
    return [[(NSArray *)items objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
    // give each some colour
    UIColor *color = [colors objectAtIndex:indexPath.section];
    NSInteger current = indexPath.row + 1;
    NSInteger total = [self.collectionView numberOfItemsInSection:indexPath.section];
    CGFloat cellAlpha = (float)current/(float)total;
    cell.backgroundColor = [color colorWithAlphaComponent:cellAlpha];
    
    // index each
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [label setText:[NSString stringWithFormat:@"%d|%d", indexPath.section, indexPath.row]];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    [cell addSubview:label];
    
    // style
//    [cell round];
    
    return cell;
}



@end

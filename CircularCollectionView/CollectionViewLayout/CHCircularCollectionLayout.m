//
//  CHCircularCollectionLayout.m
//  RotatingCollectionView
//
//  Created by Cillian on 22/03/2014.
//  Copyright (c) 2014 Cillian. All rights reserved.
//



#import "CHCircularCollectionLayout.h"
#import <math.h>
#import "Math.h"
#import "PointObj.h"

#define kCellHeight 15.0f
#define kCellWidth 11.0f

@interface CHCircularCollectionLayout()

@property (assign, nonatomic) NSArray *points;
@property (assign, nonatomic) CGPoint centerPoint;

@end

@implementation CHCircularCollectionLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    //[self trig];
    self.centerPoint = CGPointMake(150, 200);
}

- (double)positionForAttributes:(UICollectionViewLayoutAttributes *)attributes forItemAtIndexPath:(NSIndexPath *)indexPath
{

    // the cellection view center
    CGPoint pointA = self.centerPoint;

    // the collection view cell center
    CGPoint pointC = [(PointObj *)[self.points objectAtIndex:indexPath.row] point];
    
    // this is a virtual point
    CGPoint pointB = CGPointMake(pointA.x, pointC.y);
    
    double C = 0;
    
    double a = [Math distanceBetween:pointC and:pointB];
    double b = [Math distanceBetween:pointA and:pointC];
    double c = [Math distanceBetween:pointA and:pointB];
    
    double a2 = pow(a, 2);
    double b2 = pow(b, 2);
    double c2 = pow(c, 2);
    double ab2 = 2 * a * b;
    
    double val = (a2 + b2 - c2)/ab2;
    
    // check for dividing by zero like!
    val = ab2 == 0 ? 0 : val;
    
    double acosVal = acos(val);
    C = [Math radiansToDegrees:acosVal];
    
    
    double answer = 0;
    if (pointC.y + attributes.size.height/2 < self.centerPoint.y) {
        
        // top left
        if (pointC.x + attributes.size.width/2 < self.centerPoint.x) {
            answer = C - 90;
        }
        // top right
        else {
            answer = 90 - C;
        }
    }
    else {
        // bottom left
        if (pointC.x + attributes.size.width/2 < self.centerPoint.x) {
            answer = 270 - C;
        }
        // bottom right
        else {
            answer = C - 270;
        }
    }
    
    NSLog(@"%d: %f", indexPath.row, answer);
    return answer;
}

- (void)prepareLayout
{
    
    [super prepareLayout];
    
    // get a circle of points
    
    NSMutableArray *array = [NSMutableArray new];
    

    CGFloat distanceFromCenter = 100;
    CGFloat angle = 360.0f/[self.collectionView numberOfItemsInSection:0];
    
    for (CGFloat currentAngle = 0; currentAngle <= 360; currentAngle+=angle) {
        CGFloat x = distanceFromCenter * cos([Math degreesToRadians:currentAngle]) + self.centerPoint.x;
        CGFloat y = distanceFromCenter * sin([Math degreesToRadians:currentAngle]) + self.centerPoint.y;
        
        PointObj *point = [[PointObj alloc] initWithX:x andY:y];
        [array addObject:point];
    }
    
    _points = [NSArray arrayWithArray:array];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray array];
    for (int item = 0; item < [self.collectionView numberOfItemsInSection:0]; item++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}


- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    PointObj *point = [self.points objectAtIndex:indexPath.row];
    
    attributes.size = CGSizeMake(kCellWidth, kCellHeight);
    attributes.center = CGPointMake(point.x, point.y);
    if (self.cellStyle == CellStyleRotateToCenter) {
        double rotation = [self positionForAttributes:attributes forItemAtIndexPath:indexPath];
        attributes.transform = CGAffineTransformMakeRotation([Math degreesToRadians:rotation]);
    }
    
    return attributes;
}



@end

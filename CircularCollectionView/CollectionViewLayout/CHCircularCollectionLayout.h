//
//  CHCircularCollectionLayout.h
//  RotatingCollectionView
//
//  Created by Cillian on 22/03/2014.
//  Copyright (c) 2014 Cillian. All rights reserved.
//

#import <UIKit/UIKit.h>

enum CellStyle{
    CellStyleRotateToCenter,
    CellStyleFixed
};

@interface CHCircularCollectionLayout : UICollectionViewLayout

@property (nonatomic, assign) enum CellStyle cellStyle;

@end

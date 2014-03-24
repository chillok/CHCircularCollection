//
//  UIView+Custom.m
//  CircularCollectionView
//
//  Created by Cillian on 24/03/2014.
//  Copyright (c) 2014 Cillian. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

- (void)round
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
}

@end

//
//  Star.h
//  lesson24-UIViewDrawings
//
//  Created by Anatoly Ryavkin on 19/04/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Star : NSObject

@property CGPoint pointBegin;
@property CGFloat sizeRadiusStar;
@property CGFloat sizeFase;
@property NSArray*arrayPointStar;
//+(Star*)makeStarWithPointBegin: (CGPoint)pointBegin andSizeRadiusStar:(CGFloat)sizeRadiusStar andSizeFase:(CGFloat)sizeFase;

@end

NS_ASSUME_NONNULL_END

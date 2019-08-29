//
//  Draving.h
//  lesson24-UIViewDrawings
//
//  Created by Anatoly Ryavkin on 18/04/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface Drawing : UIView
-(double)returnRandomCountColor;
-(UIColor*)randomColor;
-(void)drawStarCountTop: (int) countAngle andSizeRelationTops: (CGFloat) sizeRelationTops andBeginAngle: (CGFloat) angle andRadius: (int) radius andPointCoorCenter: (CGPoint) pointCenter;
-(void)drawRandomStar;
@end


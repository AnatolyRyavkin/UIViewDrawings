//
//  ViewController.h
//  lesson24-UIViewDrawings
//
//  Created by Anatoly Ryavkin on 18/04/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drawing.h"
@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
-(double)returnRandomCountColor;
-(UIColor*)randomColor;
@end


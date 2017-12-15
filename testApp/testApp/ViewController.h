//
//  ViewController.h
//  testApp
//
//  Created by juge on 2017/10/23.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VCDelegate<NSObject>
- (void)testDelegate;
@end

@interface ViewController : BaseViewController<VCDelegate>


@end


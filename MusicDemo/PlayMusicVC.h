//
//  PlayMusicVC.h
//  MusicDemo
//
//  Created by thanh tung on 12/11/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicObject.h"
@interface PlayMusicVC : UIViewController
@property(nonatomic,strong)MusicObject * model;
@property(nonatomic,strong) NSString* linkCurrent;
@end

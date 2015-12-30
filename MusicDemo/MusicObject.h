//
//  MusicObject.h
//  MusicDemo
//
//  Created by thanh tung on 12/9/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicObject : UIViewController
@property(nonatomic,strong) NSString* urlImage;
@property(nonatomic,strong) NSString* nameMusic;
@property(nonatomic,strong) NSString* nameSinger;
@property(nonatomic,strong) NSString* viewsMusic;
@property(nonatomic,strong) NSString* linkDetail;
-(instancetype)initWithName: (NSString*)nameMusic
        andUrlImage:(NSString*)urlImg
      andSingerName:(NSString*)singer
       andViewMusic:(NSString*)viewMusic
      andLinkDetail:(NSString*)linkDetail;
@end

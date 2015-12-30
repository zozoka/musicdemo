//
//  MusicNetWork.h
//  MusicDemo
//
//  Created by thanh tung on 12/10/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MusicNetWork : NSObject
+(instancetype)shareManager;
-(void) GetMusicFromLink:(NSString*) url OnComplete:(void(^)(NSArray *items))completedMethod fail:(void(^)())failMethod;


@end

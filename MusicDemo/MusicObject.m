//
//  MusicObject.m
//  MusicDemo
//
//  Created by thanh tung on 12/9/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "MusicObject.h"

@interface MusicObject ()

@end

@implementation MusicObject

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)initWithName: (NSString*)nameMusic
        andUrlImage:(NSString*)urlImg
      andSingerName:(NSString*)singer
       andViewMusic:(NSString*)viewsMusic
      andLinkDetail:(NSString*)linkDetail{
    self = [super init];
    if (self) {
        self.nameMusic = nameMusic;
        self.urlImage = urlImg;
        self.nameSinger = singer;
        self.viewsMusic = viewsMusic;
        self.linkDetail = linkDetail;
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

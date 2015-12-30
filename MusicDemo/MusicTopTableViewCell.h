//
//  MusicTopTableViewCell.h
//  MusicDemo
//
//  Created by thanh tung on 12/10/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoMusic;
@property (weak, nonatomic) IBOutlet UILabel *nameMusic;
@property (weak, nonatomic) IBOutlet UILabel *nameSinger;
@property (weak, nonatomic) IBOutlet UILabel *views;

@end

//
//  TableViewCell.h
//  CGVAPP
//
//  Created by thanh tung on 12/8/15.
//  Copyright © 2015 DangDingCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageMovie;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCate;
@property (weak, nonatomic) IBOutlet UILabel *labelDuration;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end

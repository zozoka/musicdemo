//
//  MusicTopList.m
//  MusicDemo
//
//  Created by thanh tung on 12/9/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "MusicTopList.h"
#import "SWRevealViewController.h"
#import "MusicObject.h"
#import "MusicNetWork.h"
#import "MusicTopTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "PlayMusicVC.h"
@interface MusicTopList ()
@property(nonatomic,strong) NSMutableArray * arrayData;
@property (nonatomic, strong) PlayMusicVC *playMusicVC;
@end

@implementation MusicTopList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"BXH Quốc Tế";
    self.view.backgroundColor = [UIColor whiteColor];
    // Dispose of any resources that can be recreated.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonItem setTarget: self.revealViewController];
        [self.barButtonItem setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    CGFloat width = self.view.bounds.size.width * 0.6;
    
    [revealViewController setRearViewRevealWidth:width];
    [revealViewController setFrontViewShadowColor:[UIColor blackColor]];
    [self loadHTML];
    //NSLog(@"%@",[(MusicObject *)self.arrayData[0] nameMusic]);

    
}

-(void) loadHTML{
    [[MusicNetWork shareManager] GetMusicFromLink:@"http://www.nhaccuatui.com/bai-hat/top-20.au-my.html" OnComplete:^(NSArray * items){
        self.arrayData = [[NSMutableArray alloc] initWithArray:items];
    } fail:^{
        NSLog(@"loi");
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicTopTableViewCell *cell = (MusicTopTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MusicTopTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.nameMusic.text = [self.arrayData[indexPath.row] nameMusic];
    cell.nameSinger.text = [self.arrayData[indexPath.row] nameSinger];
    cell.views.text = [self.arrayData[indexPath.row] viewsMusic];
    NSURL * urlPhoto = [NSURL URLWithString:[self.arrayData[indexPath.row] urlImage]];
    [cell.photoMusic setImageWithURL:urlPhoto placeholderImage:[UIImage imageNamed:@"thumb"]];
    //cell.photoMusic = [self.arrayData[indexPath.row] photoMusic];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayMusicVC *playMusic = [PlayMusicVC new];
    playMusic.model = self.arrayData[indexPath.row];
    if (!self.playMusicVC) {
        self.playMusicVC = [PlayMusicVC new];
        self.playMusicVC.model = self.arrayData[indexPath.row];

        [self.navigationController pushViewController:self.playMusicVC animated:YES];
    }else{
        if ([playMusic.model.linkDetail isEqual:self.playMusicVC.model.linkDetail]) {
            [self.navigationController pushViewController:self.playMusicVC animated:YES];
        }else{
            self.playMusicVC.model = self.arrayData[indexPath.row];
            //self.playMusicVC.linkCurrent = playMusic.model.linkDetail;
            [self.navigationController pushViewController:self.playMusicVC animated:YES];
        }
        
    }
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

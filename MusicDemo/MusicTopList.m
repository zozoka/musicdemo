//
//  MusicList.m
//  MusicDemo
//
//  Created by thanh tung on 12/9/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "MusicList.h"
#import "SWRevealViewController.h"
#import "MusicObject.h"
#import "MusicNetWork.h"

@interface MusicList ()
@property(nonatomic,strong) NSMutableArray * arrayData;
@end

@implementation MusicList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"Bài hát";
    self.view.backgroundColor = [UIColor whiteColor];
    // Dispose of any resources that can be recreated.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonItem setTarget: self.revealViewController];
        [self.barButtonItem setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
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
    NSString *CellIdentifier = [self.arrayData objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

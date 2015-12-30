//
//  PlayMusicVC.m
//  MusicDemo
//
//  Created by thanh tung on 12/11/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "PlayMusicVC.h"
#import "PlayMusicVC.h"
#import "iOSRequest.h"
#import "UIImageView+AFNetworking.h"
@import AVFoundation;

@interface PlayMusicVC () <AVAudioPlayerDelegate,NSXMLParserDelegate>
@property(nonatomic,strong) UILabel * label;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UISlider *musicSlider;
@property (weak, nonatomic) IBOutlet UIButton *buttonPlayPause;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageMusic;

@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerName;

@end

@implementation PlayMusicVC
{
    NSXMLParser *parser;
    BOOL check;
    NSString * urlString;
    BOOL isPaused;
    BOOL isStoped;
    UIImageView *animationMusicImage;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self stopPlayMusic];
    NSLog(@"viewWillAppear");
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.view.backgroundColor = [UIColor whiteColor];
 
    //NSLog(@"%@",[self.model linkDetail]);
    NSURL * urlPhoto = [NSURL URLWithString:self.model.urlImage];
    [self.imageMusic setImageWithURL:urlPhoto placeholderImage:[UIImage imageNamed:@"thumb"]];
    self.musicNameLabel.text = [self.model nameMusic];
    self.singerName.text = [self.model nameSinger];
    CAShapeLayer * circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0;
    circleLayer.fillColor = [[UIColor clearColor]CGColor];
    circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    [self.imageMusic.layer addSublayer:circleLayer];
    isPaused = false;
    isStoped = false;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        // get request to nhaccuatui
        urlString = nil;
        [iOSRequest getPath:[self.model linkDetail] onComplete:^(NSString *result, NSError *error) {
            NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
            parser = [[NSXMLParser alloc] initWithData:data];
            [parser setDelegate:self];
            [parser setShouldResolveExternalEntities:NO];
            [parser parse];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
        });
    });
    
    
}


- (IBAction)playPauseTapButton:(id)sender {

    [self.timer invalidate];
    if (isPaused) {
        //NSLog(@"Play");

        [self.buttonPlayPause setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [self.audioPlayer play];
        isPaused = false;
    } else {
        //NSLog(@"Pause");

        [self.buttonPlayPause setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
        [self.audioPlayer pause]; //the pause method just pause playback, and lets you resume from where you left off later
        isPaused = true;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    if(check && [string containsString:@".mp3"])
    {
        urlString = string;
        dispatch_async(dispatch_get_main_queue(), ^{
           // NSLog(@"%@",self.audioPlayer.playing);
            if ([self.linkCurrent isEqual:self.model.linkDetail]) {
                NSLog(@"current");
                [self setupAVAudioPlayerWriteToDataWithURL:urlString];
                [self.audioPlayer stop];
                [self.audioPlayer play];
                self.linkCurrent = self.model.linkDetail;
            }else{
                [self setupAVAudioPlayerWriteToDataWithURL:urlString];
                [self.audioPlayer stop];
                [self.audioPlayer play];
                self.linkCurrent = self.model.linkDetail;
            }
        });
    }
    
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"location"] && urlString.length == 0)
    {
        check = true;
        return;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (check) {
        check = false;
    }
    
}

- (IBAction)butStop:(id)sender {
    [self.audioPlayer stop]; //the stop method stops playback completely, and unloads the sound from memory, but not reset currentTime
    [self.audioPlayer setCurrentTime:0];
    self.musicSlider.value = 0;
    self.currentTimeLabel.text = @"0:00";
    self.durationTimeLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration]];
    [self.buttonPlayPause setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
    isPaused = true;
    if ([_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
}

/* Dowload Audio Stream URL, Write to File, Must setup in Info.plist if URL is http:// */
- (void)setupAVAudioPlayerWriteToDataWithURL: (NSString*)stringURL {
    NSURL *url = [NSURL URLWithString:stringURL];
//    NSData *audioData = [NSData dataWithContentsOfURL:url];
//    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"streamAudio"];
//    [audioData writeToFile:filePath atomically:YES];
    
    //NSError *error;
//    NSURL *fileURL = [NSURL fileURLWithPath:filePath];

    //self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    //    if (error) {
    //        NSLog(@"%@",error.description);
    //    }

    //[self.audioPlayer prepareToPlay];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        NSData * data = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            self.audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:nil];
            self.audioPlayer.delegate = self;
            self.musicSlider.maximumValue = [self.audioPlayer duration];
            
            self.musicSlider.maximumTrackTintColor = [UIColor blackColor];
            self.currentTimeLabel.text = @"0:00";
            self.durationTimeLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration]];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        });
    });


}

/* Convert time (75s -> 1:15) */
- (NSString*)timeFormat: (float)time {
    int minutes = time/60;
    int seconds = (int)time % 60;
    return [NSString stringWithFormat:@"%@%d:%@%d", minutes/10 ? [NSString stringWithFormat:@"%d",minutes/10] : @"", minutes%10, [NSString stringWithFormat:@"%d", seconds/10], seconds%10];
}

/* updateTime to slider */
- (void)updateTime {
    self.musicSlider.value = [self.audioPlayer currentTime];
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%@",[self timeFormat:[self.audioPlayer currentTime]]];
    self.durationTimeLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration - self.audioPlayer.currentTime]];
}

- (IBAction)onSliderValueChange:(UISlider *)sender {
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime) userInfo:nil repeats:NO];
    [self.audioPlayer setCurrentTime:self.musicSlider.value];
}

#pragma mark AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Finish");
    [_timer invalidate];
    _timer = nil;
    [self.buttonPlayPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    isPaused = true;
}
- (void) stopPlayMusic{
    NSLog(@"Stop");
    
    [self.audioPlayer stop]; //the stop method stops playback completely, and unloads the sound from memory, but not reset currentTime
    [self.audioPlayer setCurrentTime:0];
    self.musicSlider.value = 0;
    self.currentTimeLabel.text = @"0:00";
    self.durationTimeLabel.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration]];
    [self.buttonPlayPause setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
    isPaused = true;
    if ([_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)playMusic{
    
    [self.audioPlayer prepareToPlay];
    [self.buttonPlayPause setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    [self.audioPlayer play];
}

@end

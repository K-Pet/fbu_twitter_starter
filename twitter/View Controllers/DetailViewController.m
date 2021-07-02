//
//  DetailViewController.m
//  twitter
//
//  Created by Kobe Petrus on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "DateTools.h"


@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pfpImageView;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *profilePicURL = [NSURL URLWithString:self.tweet.user.profilePicture];
    [self.pfpImageView setImageWithURL:profilePicURL];
    
    // Beyblade
    
    self.nameLabel.text = self.tweet.user.name;
    NSString *atSymbol = @"@";
    self.screennameLabel.text = [atSymbol stringByAppendingString:self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    NSString *stringDate = self.tweet.originalDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *dateDate = [formatter dateFromString:stringDate];
    
    self.createdAtLabel.text = dateDate.shortTimeAgoSinceNow;
    
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

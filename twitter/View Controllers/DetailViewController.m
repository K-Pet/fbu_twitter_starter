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
#import "APIManager.h"


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
- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;

    [[APIManager shared] favorite: self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
         }
     }];
}
- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    [[APIManager shared] retweet: self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
         }
     }];
    
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

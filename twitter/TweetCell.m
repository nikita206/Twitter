//
//  TweetCell.m
//  twitter
//
//  Created by Nikita Agarwal on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "DateTools.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePic addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePic setUserInteractionEnabled:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) {
            self.tweet.favorited = NO;
            self.tweet.favoriteCount -= 1;
        [self.changeIcon setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
            // send a POST request to the POST favorites/create endpoint
            [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                    NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                }
            }];
        }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self.changeIcon setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    
    [self refreshData];
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
            self.tweet.retweeted = NO;
            self.tweet.retweetCount -= 1;
            
            // send a POST request to the POST favorites/create endpoint
        [self.changeRetweet setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                    NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                }
            }];
        }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self.changeRetweet setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    
    [self refreshData];
}

- (void)refreshData {
    self.likes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweeted.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
}
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];
}
@end

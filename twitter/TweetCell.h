//
//  TweetCell.h
//  twitter
//
//  Created by Nikita Agarwal on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *changeRetweet;
@property (weak, nonatomic) UITableViewCell *tweetView;
@property (weak, nonatomic) IBOutlet UIButton *changeIcon;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UILabel *shared;
@property (weak, nonatomic) IBOutlet UILabel *retweeted;
@property (weak, nonatomic) IBOutlet UILabel *likes;
- (IBAction)didTapFavorite:(id)sender;

@end

NS_ASSUME_NONNULL_END

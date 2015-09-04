//
//  BuddyLocationCell.h
//  NeighbourFriends
//
//  Created by gus on 15/9/4.
//  Copyright (c) 2015年 gujitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuddyLocationCell : UITableViewCell
{
    
}

@property(nonatomic,strong)IBOutlet UIImageView*profileImageView;
@property(nonatomic,strong)IBOutlet UILabel* nameLabel;
@property(nonatomic,strong)IBOutlet UILabel* locationNameLabel;
@property(nonatomic,strong)IBOutlet UILabel* distanceLabel;
@property(nonatomic,strong)IBOutlet UILabel* addressLabel;

@end

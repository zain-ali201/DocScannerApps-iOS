//
//  DataCell.h
//  Document Scanner
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 kazuh1ko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCell : UITableViewCell

 @property(nonatomic,retain) IBOutlet UIImageView* imgView;
 @property(nonatomic,retain) IBOutlet UILabel* lblName;
 @property(nonatomic,retain) IBOutlet UILabel* lblDate;


@end

NS_ASSUME_NONNULL_END

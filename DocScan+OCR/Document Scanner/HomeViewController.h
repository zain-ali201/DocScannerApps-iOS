//
//  HomeViewController.h
//  Document Scanner
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 kazuh1ko. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView* tblView;
    IBOutlet UIImageView* imgView;
    IBOutlet UIView* emptyView;
    IBOutlet UIView* lineView;
    NSMutableArray *dataArray;
}
@end


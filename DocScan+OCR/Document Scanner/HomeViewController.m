//
//  HomeViewController.m
//  Document Scanner
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 kazuh1ko. All rights reserved.
//

#import "HomeViewController.h"
#import "PictureSelectorViewController.h"
#import "DataCell.h"
#import "ImageObject.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getDocs];
}

-(void) getDocs
{
    dataArray = [[NSMutableArray alloc]init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *imagesPath = [NSString stringWithFormat:@"%@/Images",documentsPath];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagesPath error:NULL];
    NSLog(@"%@", directoryContent);
    
    for (int i = 0; i < directoryContent.count; i++)
    {
        NSString *path = [NSString stringWithFormat:@"%@/%@",imagesPath,directoryContent[i]];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        ImageObject *imgObj = [[ImageObject alloc]init];
        NSString *name = directoryContent[i];
        imgObj.imgName = [name stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        imgObj.img = [UIImage imageWithData:data];
        
        [dataArray addObject:imgObj];
    }
    [tblView reloadData];
    
    if (dataArray.count == 0)
    {
        emptyView.alpha = 1;
        lineView.alpha = 0;
        imgView.alpha = 0;
    }
    else
    {
        emptyView.alpha = 0;
        lineView.alpha = 1;
        imgView.alpha = 0.3;
    }
}

- (void)removeDoc:(NSString *)filename
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagesPath = [NSString stringWithFormat:@"%@/Images",documentsPath];
    NSString *filePath = [imagesPath stringByAppendingPathComponent:filename];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success)
    {
      [self getDocs];
    }
    else
    {
      NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

-(IBAction)addBtnAction:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PictureSelectorViewController *picVC = (PictureSelectorViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PictureSelectorViewController"];
    [self.navigationController pushViewController:picVC animated:YES];
}

#pragma mark
#pragma mark UITableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"DataCell";
    
    DataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ImageObject *imgObj = [dataArray objectAtIndex:indexPath.row];
    
    cell.lblName.text = imgObj.imgName;
    cell.imgView.image = imgObj.img;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"DocScan" message:@"Are you sure to delete this document?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ImageObject *imgObj = [dataArray objectAtIndex:indexPath.row];
            [self removeDoc:[NSString stringWithFormat:@"%@.jpg", imgObj.imgName]];
        }];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:no];
        [alert addAction:yes];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    moreAction.backgroundColor = [UIColor redColor];
    
    return @[moreAction];
}

@end

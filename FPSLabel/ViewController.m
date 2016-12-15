//
//  ViewController.m
//  FPSLabel
//
//  Created by GiantAxe on 16/12/15.
//  Copyright © 2016年 GiantAxe. All rights reserved.
//

#import "ViewController.h"

#import "AxeFPSLabel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

// ===============================================================
//                          Life Cycle
// ===============================================================

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    AxeFPSLabel *label = [[AxeFPSLabel alloc] initWithFrame:CGRectMake(200, 200, 60, 25)];
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
}

// ===============================================================
//                          Lazy
// ===============================================================

#pragma mark - Lazy

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imgCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

// ===============================================================
//                      UITableViewDataSource
// ===============================================================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <= 50)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = @"Axe World";
        cell.textLabel.textColor = [UIColor orangeColor];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imgCell"];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_zjf"]];
        imgV.layer.cornerRadius = 3.f;
        imgV.layer.masksToBounds = YES;
        [cell.contentView addSubview:imgV];
        return cell;
    }

}

// ===============================================================
//                        UITableViewDelegate
// ===============================================================

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 50) {
        return 40;
    }
    else {
        return 60;
    }
}


@end
